/**
 * 
 */
package org.sakaiproject.resource.tool.rest;

import java.io.File;
import java.io.FileFilter;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.sakaiproject.component.cover.ComponentManager;
import org.sakaiproject.resource.api.course.model.MeleteCourseModel;
import org.sakaiproject.resource.api.course.model.MeleteTestModel;
import org.sakaiproject.resource.api.course.service.ICourseService;
import org.sakaiproject.resource.api.course.vo.StudyRecordVO;
import org.sakaiproject.resource.api.course.vo.TestAnswerVO;
import org.sakaiproject.resource.api.course.vo.TestAttemptVO;
import org.sakaiproject.resource.api.course.vo.TestContentVO;
import org.sakaiproject.resource.api.course.vo.TestVO;
import org.sakaiproject.resource.api.study.model.MeleteStudyRecordModel;
import org.sakaiproject.resource.api.study.model.MeleteTestAttemptModel;
import org.sakaiproject.resource.api.study.model.MeleteTestRecordModel;
import org.sakaiproject.resource.api.study.service.IStudyService;
import org.sakaiproject.resource.util.CacheUtil;
import org.sakaiproject.resource.util.CodeTable;
import org.sakaiproject.resource.util.Constants;
import org.sakaiproject.resource.util.DateUtil;
import org.sakaiproject.resource.util.JsonBuilder;
import org.sakaiproject.site.api.SiteService;
import org.sakaiproject.tool.api.ToolManager;

import com.bupticet.paperadmin.tool.Helper;
import com.opensymphony.xwork2.ActionSupport;

/**
 * @author yushanyuan 移动端取作业 接口
 */
public class TestAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static Log logger = LogFactory.getLog(TestAction.class);
	private static Log loggerManage = LogFactory.getLog("sysManageResourceR");

	private String courseId;
	private String userId;
	private String testId;
	private String auth;
	private String studyrecordId;
	private ICourseService courseService;
	private IStudyService studyService;
	private String testRecordId;
	private String startTime;
	private String paperId;

	private String answerContent;

	private SiteService siteService = (SiteService) ComponentManager.get(SiteService.class);

	private ToolManager toolManager = (ToolManager) ComponentManager.get(ToolManager.class);

	public String getCourseId() {
		return courseId;
	}

	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public ICourseService getCourseService() {
		return courseService;
	}

	public void setCourseService(ICourseService courseService) {
		this.courseService = courseService;
	}

	public IStudyService getStudyService() {
		return studyService;
	}

	public void setStudyService(IStudyService studyService) {
		this.studyService = studyService;
	}

	public String getTestId() {
		return testId;
	}

	public void setTestId(String testId) {
		this.testId = testId;
	}

	public String getAuth() {
		return auth;
	}

	public void setAuth(String auth) {
		this.auth = auth;
	}

	public String getStudyrecordId() {
		return studyrecordId;
	}

	public void setStudyrecordId(String studyrecordId) {
		this.studyrecordId = studyrecordId;
	}

	// -------------------------------------

	/**
	 * 4. 作业接口，从教学平台根据站点id和用户id取得该站点所有作业。(只取test，不取selftest)
	 * 
	 * @return
	 * @throws IOException
	 */
	public String getHomeworks() throws IOException {
		loggerManage.info("--进入：作业接口，从教学平台根据站点id和用户id取得该站点所有作业---");
		List<TestVO> testVOList = new ArrayList<TestVO>();

		try {
			// 获得studyrecordId
			String studyrecordId = null;
			MeleteCourseModel course = courseService.getCourseBySiteId(courseId);
			courseId = course.getId();
			// CacheElement cacheCourse =
			// CacheUtil.getInstance().getCacheOfCourse(courseId);
			MeleteStudyRecordModel study = null;
			if(course != null){
				study = CacheUtil.getInstance().checkStudyRecord(courseId, userId);
			}
			if (StringUtils.isBlank(studyrecordId)) {
				studyrecordId = study.getStudyrecordId().toString();
			}

			/*
			 * MeleteCourseModel course =
			 * courseService.getCourseBySiteId(courseId); List<MeleteTestModel>
			 * meleteTestModelList = courseService
			 * .getAllMeleteTestModelByCourseId(course.getId());
			 */

			List<MeleteTestModel> meleteTestModelList = null;

			// status,siteid,playtemplates都是新课程空间的字段
			if (StringUtils.isNotBlank(course.getSiteId())) {
				meleteTestModelList = courseService.getAllTest(course.getId());
			} else {
				meleteTestModelList = courseService.getAllTestByOldMelete(course.getId());
			}

			if (meleteTestModelList != null && meleteTestModelList.size() > 0) {

				List<MeleteTestRecordModel> meTestRecordModelList = studyService.getTestRecordByStudyrecordId(studyrecordId);

				for (MeleteTestModel tm : meleteTestModelList) {
					TestVO vo = new TestVO();
					vo.setTestId(tm.getId().toString());
					vo.setModuleId(tm.getModuleId() != null ? tm.getModuleId().toString() : "");
					vo.setSectionId(tm.getSectionId() != null ? tm.getSectionId().toString() : "");
					vo.setName(tm.getName());
					vo.setMinInterval(tm.getMinTimeInterval());
					vo.setOpenStart(tm.getStartOpenDate());
					vo.setOpenEnd(tm.getEndOpenDate());
					if (meTestRecordModelList != null && !meTestRecordModelList.isEmpty()) {
						// 遍历记录
						boolean flag = false;
						for (MeleteTestRecordModel mm : meTestRecordModelList) {
							if (flag) {
								break;
							}
							if (tm.getId().equals(mm.getTestId())) {
								vo.setIsPass(mm.getStatus() != null ? mm.getStatus().toString() : "");
								vo.setScore(mm.getScore() != null ? mm.getScore().toString() : "");
								vo.setTotalNum(mm.getAttemptNumber() != null ? mm.getAttemptNumber().toString() : "");

								flag = true;
							}
						}
					}
					testVOList.add(vo);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("UTF-8");
		String json = "";

		json = JsonBuilder.builderFormJson(testVOList);

		response.getWriter().println(json);
		loggerManage.info("--离开：作业接口，从教学平台根据站点id和用户id取得该站点所有作业---");

		return null;
	}

	/**
	 * 5. 作业接口，从教学平台根据站点id和用户id取得某项作业全部做题记录
	 * 
	 * @return
	 * @throws IOException
	 */
	public String getHomeworkInfo() throws IOException {
		loggerManage.info("--进入：作业接口，从教学平台根据站点id和用户id取得该站点某项作业全部做题记录---");
		List<TestAttemptVO> testAttemptVOList = new ArrayList<TestAttemptVO>();
		try {
			// 获得studyrecordId
			String studyrecordId = null;
			MeleteStudyRecordModel study = null;
			MeleteCourseModel course = courseService.getCourseBySiteId(courseId);
			courseId = course.getId();
			if(course != null){
				study = CacheUtil.getInstance().checkStudyRecord(courseId, userId);
			}
			if (StringUtils.isBlank(studyrecordId)) {
				studyrecordId = study.getStudyrecordId().toString();
			}
			loggerManage.info("--studyrecordId--:" + studyrecordId);
			

			// 获取作业记录
			MeleteTestRecordModel testRecord = studyService.getTestRecordById(studyrecordId,
					String.valueOf(testId));

			List<MeleteTestAttemptModel> meleteTestAttempModelList = courseService.getAllMeleteTestAttemptModelByTestRecordId(testRecord
					.getTestrecordId().toString());
			if (meleteTestAttempModelList != null && meleteTestAttempModelList.size() > 0) {
				// 封装尝试记录数据
				// testAttemptVOList = new ArrayList<TestAttemptVO>();
				// 遍历尝试记录得到并封装数据
				for (MeleteTestAttemptModel m : meleteTestAttempModelList) {
					TestAttemptVO map = new TestAttemptVO();
					map.setTestAttemptId(m.getTestattemptId().toString());
					map.setTestName(testRecord.getTestName());
					map.setTestRecordId(testRecord.getTestId() != null ? testRecord.getTestId().toString() : "");
					map.setScore(m.getScore() != null ? m.getScore().toString() : "");
					map.setSubScore(m.getSubScore() != null ? m.getSubScore().toString() : "");
					map.setObjScore(m.getObjScore() != null ? m.getObjScore().toString() : "");
					String startDate = "";
					if (m.getStartTime() != null) {
						startDate = DateUtil.dateToString(m.getStartTime(), DateUtil.dateTimeStr);
					}
					map.setStartStudyTime(startDate);
					testAttemptVOList.add(map);
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("UTF-8");
		String json = "";

		json = JsonBuilder.builderFormJson(testAttemptVOList);

		response.getWriter().println(json);
		loggerManage.info("--离开：作业接口，从教学平台根据站点id和用户id取得该站点某项作业全部做题记录---" + json);

		return null;
	}

	/**
	 * 6. 作业接口，从教学平台根据站点id和用户id取得某次作业内容
	 * 
	 * @return
	 * @throws IOException
	 */
	public String getHomeworkContent() throws IOException {
		try {
			loggerManage.info("--进入：作业接口，从教学平台根据站点id和用户id取得某次作业内容---");
			HttpServletResponse response = ServletActionContext.getResponse();
			response.setCharacterEncoding("UTF-8");
			String json = "";
			String studyrecordId = "";
			String data = "";
			String testPaperId = "";
			TestContentVO testContentVO = new TestContentVO();
			MeleteCourseModel course = courseService.getCourseBySiteId(courseId);
			courseId = course.getId();
			MeleteTestModel test = null;
			if(StringUtils.isNotBlank(testId)){
				test = courseService.getTest(Long.parseLong(testId));
			}
			if (test != null) {
				MeleteStudyRecordModel study = CacheUtil.getInstance().checkStudyRecord(courseId, userId);
				if (StringUtils.isBlank(studyrecordId)) {
					studyrecordId = study.getStudyrecordId().toString();
				}
				loggerManage.info("--studyrecordId--:" + studyrecordId);

				// 获取作业记录
				MeleteTestRecordModel testRecord = studyService.getTestRecordById(studyrecordId,
						String.valueOf(testId));
				// 第一次加载作业树时保存相应课程作业记录
				if (testRecord == null) {
					testRecord = new MeleteTestRecordModel();
					testRecord.setTestId(test.getId());
					testRecord.setCourseId(course.getId());
					testRecord.setScore(0F);
					testRecord.setAttemptNumber(0L);
					testRecord.setStatus(Long.valueOf(CodeTable.passStatusNo));
					testRecord.setModuleId(test.getModuleId());
					testRecord.setSectionId(test.getSectionId());
					testRecord.setStudyrecordId(Long.valueOf(studyrecordId));
					testRecord.setTestName(test.getName());
					studyService.saveTestRecord(testRecord);
				}
				
				String testrecordId = testRecord.getTestrecordId().toString();
				loggerManage.info("--testrecordId--:" + testrecordId);
				
				String passScore = test.getMasteryScore().toString();
				String samepaper = test.getSamepaper();
				loggerManage.info("--passScore--:" + passScore);
				loggerManage.info("--samepaper--:" + samepaper);
				Long minInterval = test.getMinTimeInterval();
				if (minInterval == null) {
					minInterval = Long.parseLong(Constants.TEST_MININTERVAL);
				}
				if (testRecord.getAttemptNumber() > 0) {
					Calendar c = Calendar.getInstance();
					c.setTime(testRecord.getLastCommitTime());
					c.add(Calendar.SECOND, (int) (minInterval * 60));
					if (c.compareTo(Calendar.getInstance()) > 0) {
						testContentVO.setErrorFlag("needWait");
						testContentVO.setErrorTip("作业间隔时间为" + minInterval + "分钟，请稍后。");
						json = JsonBuilder.builderFormJson(testContentVO);
						response.getWriter().println(json);
						return null;
					}
				}
				if((test.getStartOpenDate() != null && new Date().before(test.getStartOpenDate())) || (test.getEndOpenDate() != null && new Date().after(test.getEndOpenDate()))){
					testContentVO.setErrorFlag("timeOut");
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					String startDateStr = "";
					String endDateStr = "";
					if(test.getStartOpenDate() != null){
						startDateStr = sdf.format(test.getStartOpenDate())+"开始";
					}
					if(test.getEndOpenDate() != null){
						endDateStr = sdf.format(test.getEndOpenDate())+"结束";
					}
					testContentVO.setErrorTip("作业开放时间为" + startDateStr + " "+endDateStr);
					json = JsonBuilder.builderFormJson(testContentVO);
					response.getWriter().println(json);
					return null;
				}
				String studentId = userId;
				// 文件保存路径
				try {
					String path = Constants.getStuTestPath(studentId, courseId);

					String testPaperName = null;
					if (samepaper.equals(CodeTable.samePaperYes)) {// 每次使用同一试卷
						testPaperName = Helper.TestPrefix + testId + Helper.EndTag;
						File destFile = new File(path, testPaperName);
						File aDestFile = new File(path, Helper.getAnswerName(testPaperName));
						if (!destFile.exists() || !aDestFile.exists()) {
							// 拷贝试卷文件
							File srcFile = getTestRandomPaper(courseId, testId);
							FileUtils.copyFile(srcFile, destFile);
							// 拷贝答案文件
							File aSrcFile = new File(Constants.getTestLibAnswerPath(courseId, testId), Helper.getAnswerName(srcFile.getName()));
							FileUtils.copyFile(aSrcFile, aDestFile);
						}
					} else {
						File srcFile = getTestRandomPaper(courseId, testId);
						testPaperName = srcFile.getName();
						File destFile = new File(path, testPaperName);
						File aDestFile = new File(path, Helper.getAnswerName(testPaperName));
						if (!destFile.exists() || !aDestFile.exists()) {
							FileUtils.copyFile(srcFile, destFile);
							// 拷贝答案文件
							File aSrcFile = new File(Constants.getTestLibAnswerPath(courseId, testId), Helper.getAnswerName(testPaperName));
							FileUtils.copyFile(aSrcFile, aDestFile);
						}
					}
					testPaperId = Helper.getPaperId(testPaperName);
					// content =
					// ServerActionTool.exportExercisePaper(Constants.getTestMaterialURL(courseId),
					// path, testPaperName);
					File file = new File(path, testPaperName);
					if (!file.exists()) {
						testContentVO.setErrorFlag("paperNotFound");
						testContentVO.setErrorTip("没有找到试卷");
						json = JsonBuilder.builderFormJson(testContentVO);
						response.getWriter().println(json);
						return null;
					}
					data = FileUtils.readFileToString(file, "UTF8");
				} catch (Exception e) {
					testContentVO.setErrorFlag("paperNotFound");
					testContentVO.setErrorTip("没有找到试卷");
					json = JsonBuilder.builderFormJson(testContentVO);
					response.getWriter().println(json);
					return null;
				}

				testContentVO.setCourseId(courseId);
				testContentVO.setTestId(testId);
				testContentVO.setSamePaper(samepaper.equals(CodeTable.samePaperYes));
				testContentVO.setStartTime(DateUtil.dateToString(new Date(), DateUtil.dateTimeStr));
				testContentVO.setPassScore(passScore);
				testContentVO.setTestRecordId(testrecordId);
				testContentVO.setStudyRecordId(studyrecordId);
				testContentVO.setPaperId(testPaperId);
				testContentVO.setPaperContent(data);
				json = JsonBuilder.builderFormJson(testContentVO);
				response.getWriter().println(json);
				return null;
			}

			loggerManage.info("--离开：作业接口，从教学平台根据站点id和用户id取得某次作业内容---");

		} catch (Exception e) {
			e.printStackTrace();
			StringWriter sw = new StringWriter();
			e.printStackTrace(new PrintWriter(sw, true));
			loggerManage.error("取得某次作业内容 报错：-" + courseId + " " + testId + ":" + sw.toString());
		}
		return null;

	}

	/**
	 * 保存学生提交的答案
	 * 
	 * @return
	 * @throws Exception
	 */
	public String homeworkAnswerSave() throws Exception {
		loggerManage.info("--进入：答案保存接口，---");
		loggerManage.info("--courseId--" + courseId + "--studyrecordId -" + studyrecordId + "--testId -" + testId + "--testRecordId -" + testRecordId
				+ "--startTime -" + startTime);
		TestAnswerVO testAnswerVO = new TestAnswerVO();

		String studentId = userId;
		MeleteCourseModel course = courseService.getCourseBySiteId(courseId);
		courseId = course.getId();
		MeleteStudyRecordModel study = null;
		if(course != null){
			study = CacheUtil.getInstance().checkStudyRecord(courseId, userId);
		}
		if (StringUtils.isBlank(studyrecordId)) {
			studyrecordId = study.getStudyrecordId().toString();
		}
		loggerManage.info("--studyrecordId--:" + studyrecordId);
		MeleteTestModel test = courseService.getTest(Long.parseLong(testId));
		String passScore = test.getMasteryScore().toString();
		String samepaper = test.getSamepaper();
		loggerManage.info("--passScore--:" + passScore);
		loggerManage.info("--samepaper--:" + samepaper);
		MeleteTestAttemptModel testAttempt = null;
		try {
			if (StringUtils.isNotBlank(course.getSiteId())) {
				testAttempt = studyService.saveTestAttempt(courseId, testRecordId, studentId, paperId, answerContent,
						"" + DateUtil.stringToDate(startTime, DateUtil.dateTimeStr).getTime(), passScore, studyrecordId, testId);
			} else {
				testAttempt = studyService.saveOldMeleteTestAttempt(courseId, testRecordId, studentId, paperId, answerContent,
						"" + DateUtil.stringToDate(startTime, DateUtil.dateTimeStr).getTime(), passScore, studyrecordId, testId);
			}
			
			Long attempId = testAttempt.getTestattemptId();
			String paperName = Helper.getPaperName(paperId);
			String answerName = Helper.getStuAnswerName(paperId, attempId.toString());
			String path2 = Constants.getStuTestPath(studentId, courseId);
			// content =
			// ServerActionTool.exportExamInfPaper(Constants.getTestMaterialURL(courseId),
			// path2, paperName,
			// path2, answerName, samepaper.equals(CodeTable.samePaperNo));

			File paperfile = new File(path2, paperName);
			if (!paperfile.exists()) {
				return null;
			}
			String paperfiledata = FileUtils.readFileToString(paperfile, "UTF8");

			File answerfile = new File(path2, answerName);
			if (!answerfile.exists()) {
				return null;
			}
			String answerfiledata = FileUtils.readFileToString(answerfile, "UTF8");

			testAnswerVO.setCourseId(courseId);
			testAnswerVO.setTestAttemptId(attempId.toString());
			testAnswerVO.setTestRecordId(testRecordId);
			testAnswerVO.setPaperId(paperId);
			testAnswerVO.setOrderIndex(testAttempt.getOrderIndex().intValue());
			testAnswerVO.setStartTime(startTime);
			testAnswerVO.setEndTime(DateUtil.dateToString(testAttempt.getEndTime(), DateUtil.dateTimeStr));
			testAnswerVO.setObjScore(testAttempt.getObjScore().toString());
			testAnswerVO.setSubScore(testAttempt.getSubScore().toString());
			testAnswerVO.setScore(testAttempt.getScore().toString());
			testAnswerVO.setShowAnswer(samepaper.equals(CodeTable.samePaperNo));
			testAnswerVO.setPaperStatus(testAttempt.getPagerstatus());
			testAnswerVO.setPaperContent(paperfiledata);
			testAnswerVO.setAnswerContent(answerfiledata);

		} catch (Exception e) {
			e.printStackTrace();
			StringWriter sw = new StringWriter();
			e.printStackTrace(new PrintWriter(sw, true));
			loggerManage.error("保存答案报错：-" + courseId + " " + paperId + ":" + sw.toString());
			throw e;
		}

		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("UTF-8");
		String json = "";
		json = JsonBuilder.builderFormJson(testAnswerVO);

		response.getWriter().println(json);
		loggerManage.info("--离开：答案保存接口，---");

		return null;
	}

	/**
	 * 7. 作业接口，从教学平台根据站点id和用户id取得学习记录
	 * 
	 * @return
	 * @throws IOException
	 */
	public String getStudyRecord() throws Exception {
		loggerManage.info("--进入：作业接口，从教学平台根据站点id和用户id取学习记录---");
		StudyRecordVO vo = new StudyRecordVO();
		MeleteCourseModel course = courseService.getCourseBySiteId(courseId);
		courseId = course.getId();
		MeleteStudyRecordModel sm = null;
		if(course != null){
			sm = CacheUtil.getInstance().checkStudyRecord(courseId, userId);
		}

		if (sm != null) {
			vo.setStudyrecordId(sm.getStudyrecordId() != null ? sm.getStudyrecordId().toString() : "");
			vo.setScore(sm.getScore() != null ? sm.getScore().toString() : "");
			vo.setAttemptNumber(sm.getAttemptNumber() != null ? sm.getAttemptNumber().toString() : "");
			vo.setTotalTime(sm.getTotalTime() != null ? sm.getTotalTime().toString() : "");
			vo.setComments(sm.getComments());
			if (sm.getStartStudyTime() != null) {
				String startStudyTime = DateUtil.dateToString(sm.getStartStudyTime(), DateUtil.dateTimeStr);
				vo.setStartStudyTime(startStudyTime);
			}

			if (sm.getCoursePassTime() != null) {
				String coursePassTime = DateUtil.dateToString(sm.getCoursePassTime(), DateUtil.dateTimeStr);
				vo.setCoursePassTime(coursePassTime);
			}

			if (sm.getScoreUpdateTime() != null) {
				String scoreUpdateTime = DateUtil.dateToString(sm.getScoreUpdateTime(), DateUtil.dateTimeStr);
				vo.setScoreUpdateTime(scoreUpdateTime);
			}

			vo.setCoursechoiceplanId(sm.getCoursechoiceplanId());

		}

		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("UTF-8");
		String json = "";

		json = JsonBuilder.builderFormJson(vo);

		response.getWriter().println(json);
		loggerManage.info("--离开：作业接口，从教学平台根据站点id和用户id取学习记录---");

		return null;
	}

	private static File getTestRandomPaper(String courseId, String testId) throws Exception {
		File p = new File(Constants.getTestLibPath(courseId, testId));
		if (!p.exists() || !p.isDirectory()) {
			throw new Exception("Can't found the test paper lib path!");
		}
		// only get the json
		File[] fList = p.listFiles(new FileFilter() {
			public boolean accept(File arg0) {
				if (arg0.getName().endsWith(Helper.EndTag)) {
					return true;
				}
				return false;
			}
		});

		int fSum = fList.length;
		if (fSum <= 0) {
			throw new Exception("Can't found papers in the test paper lib directory!");
		}
		Random r = new Random();
		int fNum = r.nextInt(fSum);
		return fList[fNum];
	}

	public String getTestRecordId() {
		return testRecordId;
	}

	public void setTestRecordId(String testRecordId) {
		this.testRecordId = testRecordId;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getPaperId() {
		return paperId;
	}

	public void setPaperId(String paperId) {
		this.paperId = paperId;
	}

	public String getAnswerContent() {
		return answerContent;
	}

	public void setAnswerContent(String answerContent) {
		this.answerContent = answerContent;
	}

}
