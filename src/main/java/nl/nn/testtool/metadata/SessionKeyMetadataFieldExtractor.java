/*
   Copyright 2020, 2022-2025 WeAreFrank!, 2018 Nationale-Nederlanden

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/
package nl.nn.testtool.metadata;

import java.util.Iterator;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import nl.nn.testtool.Checkpoint;
import nl.nn.testtool.Report;

/**
 * @author Peter Leeuwenburgh
 */
public class SessionKeyMetadataFieldExtractor extends
		DefaultValueMetadataFieldExtractor {
	protected String sessionKey;
	protected String regex;
	protected Pattern pattern;

	public void setSessionKey(String sessionKey) {
		this.sessionKey = sessionKey;
	}

	public void setRegex(String regex) {
		this.regex = regex;
		if (regex == null) {
			pattern = null;
		} else {
			pattern = Pattern.compile(regex);
		}
	}

	public Object extractMetadata(Report report) {
		return report.getCheckpoints().stream()
			.filter(this::isRelevantCheckpoint)
			.map(this::extractValueFromCheckpoint)
			.filter(value -> value != null)
			.findFirst()
			.orElse(defaultValue);
	}
	
	private boolean isRelevantCheckpoint(Checkpoint checkpoint) {
		String checkpointName = checkpoint.getName();
		return checkpointName.startsWith("SessionKey ") 
			   && checkpointName.substring("SessionKey ".length()).equals(sessionKey);
	}
	
	private String extractValueFromCheckpoint(Checkpoint checkpoint) {
		String message = checkpoint.getMessage();
		if (message == null || pattern == null) {
			return message;
		}
		Matcher matcher = pattern.matcher(message);
		return matcher.find() ? matcher.group(matcher.groupCount()) : null;
	}

}
