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
<template:addResources type="javascript" resources="jquery.min.js,jquery.toc.js"/>
<c:set var="heading" value="${currentNode.properties.heading.string}"/>
<c:if test="${empty heading}">
    <c:set var="heading" value="h2"/>
</c:if>
<c:set var="depth" value="${currentNode.properties.depth.string}"/>
<c:if test="${empty depth}">
    <c:set var="depth" value="1"/>
</c:if>
<c:choose>
    <c:when test="${heading eq 'h1'}">
        <c:choose>
            <c:when test="${depth eq '1'}"><c:set var="tocHeadings" value="h1"/></c:when>
            <c:when test="${depth eq '2'}"><c:set var="tocHeadings" value="h1,h2"/></c:when>
            <c:when test="${depth eq '3'}"><c:set var="tocHeadings" value="h1,h2,h3"/></c:when>
            <c:when test="${depth eq '4'}"><c:set var="tocHeadings" value="h1,h2,h3,h4"/></c:when>
        </c:choose>
    </c:when>
    <c:when test="${heading eq 'h2'}">
        <c:choose>
            <c:when test="${depth eq '1'}"><c:set var="tocHeadings" value="h2"/></c:when>
            <c:when test="${depth eq '2'}"><c:set var="tocHeadings" value="h2,h3"/></c:when>
            <c:when test="${depth eq '3'}"><c:set var="tocHeadings" value="h2,h3,h4"/></c:when>
            <c:when test="${depth eq '4'}"><c:set var="tocHeadings" value="h2,h3,h4,h5"/></c:when>
        </c:choose>
    </c:when>
    <c:when test="${heading eq 'h3'}">
        <c:choose>
            <c:when test="${depth eq '1'}"><c:set var="tocHeadings" value="h3"/></c:when>
            <c:when test="${depth eq '2'}"><c:set var="tocHeadings" value="h3,h4"/></c:when>
            <c:when test="${depth eq '3'}"><c:set var="tocHeadings" value="h3,h4,h5"/></c:when>
            <c:when test="${depth eq '4'}"><c:set var="tocHeadings" value="h3,h4,h5,h6"/></c:when>
        </c:choose>
    </c:when>
    <c:when test="${heading eq 'h4'}">
        <c:choose>
            <c:when test="${depth eq '1'}"><c:set var="tocHeadings" value="h4"/></c:when>
            <c:when test="${depth eq '2'}"><c:set var="tocHeadings" value="h4,h5"/></c:when>
            <c:when test="${depth eq '3'}"><c:set var="tocHeadings" value="h4,h5,h6"/></c:when>
            <c:when test="${depth eq '4'}"><c:set var="tocHeadings" value="h4,h5,h6,h7"/></c:when>
        </c:choose>
    </c:when>
</c:choose>
<c:set var="bindedComponent" value="${ui:getBindedComponent(currentNode, renderContext, 'j:bindedComponent')}"/>
<c:if test="${bindedComponent != null}">
    <c:if test="${!(bindedComponent.primaryNodeType eq 'jacademy:document')}">
        <%-- If bound component  is not a document search for a document in its children --%>
        <c:set var="documentChildren" value="${jcr:getChildrenOfType(bindedComponent,'jacademy:document')}"/>
        <c:if test="${fn:length(documentChildren)>0}">
            <c:set var="bindedComponent" value="${documentChildren[0]}"/>
        </c:if>
    </c:if>
</c:if>
<c:choose>
    <c:when test="${bindedComponent.path eq renderContext.mainResource.node.path}">
        <c:set var="toc" value="body"/>
    </c:when>
    <c:otherwise>
        <c:set var="toc" value="div#toc_${bindedComponent.identifier}"/>
    </c:otherwise>
</c:choose>
<c:set var="currentPageNode" value="${renderContext.mainResource.node}"/>
<c:set var="isMultiplePageDoc" value="${jcr:isNodeType(currentPageNode, 'jacademix:isMultiplePageDoc')}"/>


<nav class="bs-docs-sidebar hidden-print hidden-sm hidden-xs hidden-print <c:if test="${!renderContext.editMode}">affix</c:if>" id="sidebar" >
    <c:set var="parentPage" value="${jcr:getParentOfType(currentPageNode, 'jmix:navMenuItem')}"/>
    <c:set var="sisterPages" value="${jcr:getChildrenOfType(parentPage, 'jnt:page')}"/>
    <c:set var="currentPageIndex" value="0"/>

    <c:choose>
        <c:when test="${isMultiplePageDoc}">
            <a href="#top" data-scrollto="#top"><strong>${parentPage.displayableName}</strong></a>
            <c:forEach items="${sisterPages}" var="sisterPage" varStatus="status">
                <c:choose>
                    <c:when test="${currentPageNode.path eq sisterPage.path}">
                        <a href="#top" data-scrollto="#top"><strong>${currentPageNode.displayableName}</strong></a>
                        <ul data-toc="${toc}" data-toc-headings="${tocHeadings}" class="nav bs-docs-sidenav sister" ></ul>
                    </c:when>
                    <c:otherwise>
                        <c:url var="pageUrl" value="${sisterPage.url}"/>
                        <a href="${pageUrl}" class="sister light back-to-top notopmargin"> ${sisterPage.displayableName}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <c:forEach items="${sisterPages}" var="sisterPage" varStatus="status">
                <c:if test="${currentPageNode.path eq sisterPage.path}">
                    <c:set var="currentPageIndex" value="${status.index}"/>
                </c:if>
            </c:forEach>
            <%--
            <c:if test="${currentPageIndex - 1 >= 0}">
                <c:set var="previousPageNode" value="${sisterPages[currentPageIndex - 1]}"/>
                <c:url var="previousPageUrl" value="${previousPageNode.url}"/>
                <a href="${previousPageUrl}" class="text-success back-to-top notopmargin"> Prev <i class="fa fa-angle-double-right" aria-hidden="true"></i> ${previousPageNode.displayableName}</a>
            </c:if>
            --%>
            <ul data-toc="${toc}" data-toc-headings="${tocHeadings}" class="nav bs-docs-sidenav" ></ul>
            <%--
            <c:if test="${currentPageIndex + 1 < fn:length(sisterPages)}">
                <c:set var="nextPageNode" value="${sisterPages[currentPageIndex + 1]}"/>
                <c:url var="nextPageUrl" value="${nextPageNode.url}"/>
                <a href="${nextPageUrl}" class="text-success back-to-top nobottommargin"> Next <i class="fa fa-angle-double-right" aria-hidden="true"></i> ${nextPageNode.displayableName}</a>
            </c:if>
            --%>
        </c:otherwise>
    </c:choose>

    <a href="#top" data-scrollto="#top" class="back-to-top light mt20"> Back to top <i class="fa fa-level-up" aria-hidden="true"></i></a>
    <a href="#" id="incfont">A+</a>
    <a href="#" id="decfont">A-</a>
</nav>
