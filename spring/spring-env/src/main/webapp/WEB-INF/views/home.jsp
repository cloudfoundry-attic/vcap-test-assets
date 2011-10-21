<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ page session="false" %>
<html>
<head>
	<title>Spring 3.1 on Cloud Foundry</title>
</head>
<body>
	<dl>
		<dt>Environment</dt>
		<dd>${environmentType}</dd>

		<dt>Default Profiles</dt>
		<dd>
			<ul>
				<c:forEach items="${defaultProfiles}" var="profile">
					<li>${profile}</li>
				</c:forEach>
			</ul>
		</dd>

		<dt>Active Profiles</dt>
		<dd>
			<ul>
				<c:forEach items="${activeProfiles}" var="profile">
					<li>${profile}</li>
				</c:forEach>
			</ul>
		</dd>

		<dt>System Environment</dt>
		<dd>
			<dl>
				<c:forEach items="${systemEnvironment}" var="env">
					<dt>${env.key}</dt>
					<dd>${env.value}</dd>
				</c:forEach>
			</dl>
		</dd>

		<dt>Property Sources</dt>
		<dd>
			<ul>
				<c:forEach items="${propertySources}" var="source">
					<li>
						${source.name}
						<dl>
							<c:forEach items="${source.propertyNames}" var="name">
								<dt>${name}</dt>
								<dd><spring:eval expression="source.getProperty(name)" /></dd>
							</c:forEach>
						</dl>
					</li>
				</c:forEach>
			</ul>
		</dd>

		<dt>System Properties</dt>
		<dd>
			<dl>
				<c:forEach items="${systemProperties}" var="prop">
					<dt>${prop.key}</dt>
					<dd>${prop.value}</dd>
				</c:forEach>
			</dl>
		</dd>

	</dl>
</body>
</html>
