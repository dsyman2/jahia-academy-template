<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="s" uri="http://www.jahia.org/tags/search" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>
<!-- display previous / next buttons -->
<div class="navbuttons">
    <ul class="pager">
        <template:include view="flat"/>
    </ul>
</div>
<%--
<c:set var="currentPageNode" value="${renderContext.mainResource.node}"/>
<c:set var="parentPage" value="${jcr:getParentOfType(currentPageNode, 'jmix:navMenuItem')}"/>
<c:set var="sisterPages" value="${jcr:getChildrenOfType(parentPage, 'jmix:navMenuItem')}"/>
<c:set var="currentPageIndex" value="0"/>
<div class="row navbuttons">
    <c:if test="${fn:length(sisterPages)>1}">
        <c:forEach items="${sisterPages}" var="sisterPage" varStatus="status">
            <c:if test="${currentPageNode.path eq sisterPage.path}">
                <c:set var="currentPageIndex" value="${status.index}"/>
            </c:if>
        </c:forEach>


        <c:if test="${currentPageIndex - 1 >= 0}">
            <c:set var="previousPageNode" value="${sisterPages[currentPageIndex - 1]}"/>

            <c:choose>
                <c:when test="${jcr:isNodeType(previousPageNode, 'jnt:navMenuText')}">
                    <c:set var="previousSubPages"
                           value="${jcr:getChildrenOfType(previousPageNode, 'jnt:page')}"/>
                    <c:forEach items="${previousSubPages}" var="previousSubPage" varStatus="status">
                        <c:if test="${status.first}">
                            <c:url var="previousPageUrl" value="${previousSubPage.url}"/>
                        </c:if>
                    </c:forEach>
                </c:when>
                <c:when test="${jcr:isNodeType(previousPageNode,'jnt:page' )}">
                    <c:url var="previousPageUrl" value="${previousPageNode.url}"/>
                </c:when>
            </c:choose>
            <c:if test="${! empty previousPageUrl}">
                <a class="btn btn-link pull-left" href="${previousPageUrl}" ><i
                        class="fa fa-arrow-left fa-fw"></i>Previous: ${previousPageNode.displayableName}</a>
            </c:if>
        </c:if>
        <c:if test="${currentPageIndex + 1 < fn:length(sisterPages)}">
            <c:set var="nextPageNode" value="${sisterPages[currentPageIndex + 1]}"/>

            <c:choose>
                <c:when test="${jcr:isNodeType(nextPageNode, 'jnt:navMenuText')}">
                    <c:set var="nextSubPages"
                           value="${jcr:getChildrenOfType(nextPageNode, 'jnt:page')}"/>
                    <c:forEach items="${nextSubPages}" var="nextSubPage" varStatus="status">
                        <c:if test="${status.first}">
                            <c:url var="nextPageUrl" value="${nextSubPage.url}"/>
                        </c:if>
                    </c:forEach>
                </c:when>
                <c:when test="${jcr:isNodeType(nextPageNode,'jnt:page' )}">
                    <c:url var="nextPageUrl" value="${nextPageNode.url}"/>
                </c:when>
            </c:choose>
            <c:if test="${! empty nextPageUrl}">
                <a class="btn btn-link pull-right" href="${nextPageUrl}" >Next: ${nextPageNode.displayableName}&nbsp;<i
                        class="fa fa-arrow-right"></i></a>
            </c:if>
        </c:if>

    </c:if>
</div>
--%>