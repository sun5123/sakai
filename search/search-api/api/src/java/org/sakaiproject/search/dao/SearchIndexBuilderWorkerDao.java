/**********************************************************************************
 * $URL$
 * $Id$
 ***********************************************************************************
 *
 * Copyright (c) 2003, 2004, 2005, 2006 The Sakai Foundation.
 *
 * Licensed under the Educational Community License, Version 1.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.opensource.org/licenses/ecl1.php
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 **********************************************************************************/

package org.sakaiproject.search.dao;

import java.io.IOException;

import org.sakaiproject.search.api.SearchIndexBuilderWorker;


public interface SearchIndexBuilderWorkerDao
{

	/**
	 * This method processes the list of document modifications in the list
	 * @param worker 
	 * 
	 * @param runtimeToDo
	 * @throws IOException
	 * @throws HibernateException
	 */
	void processToDoListTransaction(SearchIndexBuilderWorker worker);

	/**
	 * If the implementation of the SearchIndexBuilder requires that the call aquires a lock
	 * before processing.
	 * @return true is a lock should be taken prior to processToDoTransaction
	 */
	boolean isLockRequired();


}