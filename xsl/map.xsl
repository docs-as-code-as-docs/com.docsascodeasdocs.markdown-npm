<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:template match="text()" mode="yaml-toc"/>
    
    <xsl:output method="text"
        encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="/">
        <xsl:apply-templates mode="yaml-toc"/>
    </xsl:template>
    
    <!-- <MAP> -->
    <xsl:template match="*[contains(@class, ' map/map ')]" mode="yaml-toc">
        <xsl:apply-templates mode="yaml-toc"/>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' map/map ')]"/>

    <!-- <TITLE> -->
    <xsl:template match="*[contains(@class, ' topic/title ') and parent::*[contains(@class, ' map/map ')]]" mode="yaml-toc"/>
    <xsl:template match="*[contains(@class, ' topic/title ') and parent::*[contains(@class, ' map/map ')]]"/>
    
    <!-- <TOPICGROUP> -->
    <xsl:template match="*[contains(@class, ' map/topicref mapgroup-d/topicgroup ')]" mode="yaml-toc">
        <xsl:apply-templates mode="yaml-toc"/>
    </xsl:template>
    
    <!-- <TOPICHEAD> -->
    <xsl:template match="*[contains(@class, ' map/topicref mapgroup-d/topichead ')]" mode="yaml-toc">
        <xsl:apply-templates mode="yaml-toc"/>
    </xsl:template>
    
    <!-- <TOPICMETA> -->
    <xsl:template match="*[contains(@class, ' map/topicmeta ') 
                           and parent::*[contains(@class, ' mapgroup-d/topichead ')]]" mode="yaml-toc">
        <xsl:apply-templates mode="yaml-toc"/>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' map/topicmeta ') 
                           and not(ancestor::*[contains(@class, ' map/relcell ')])
                           and not(parent::*[contains(@class, ' mapgroup-d/topichead ')])
                           and not(parent::*[contains(@class, ' mapgroup-d/keydef ')])]" mode="yaml-toc">
        <xsl:variable name="ancestors" select="count(ancestor::*[contains(@class, ' map/topicref ')]) - 1"/>
        <xsl:call-template name="spaceMaker">
            <xsl:with-param name="levels" select="$ancestors"/>
        </xsl:call-template>
        <xsl:text>  title: "</xsl:text>
        <xsl:apply-templates select="*[contains(@class, ' map/linktext ')]" mode="yaml-toc"/>
        <xsl:text>"&#xA;</xsl:text>
        <xsl:call-template name="spaceMaker">
            <xsl:with-param name="levels" select="$ancestors"/>
        </xsl:call-template>
        <xsl:text>  description: "</xsl:text>
        <xsl:apply-templates select="*[contains(@class, ' map/shortdesc ')]" mode="yaml-toc"/>
        <xsl:text>"&#xA;</xsl:text>
        <xsl:if test="following-sibling::*[contains(@class, ' map/topicref ')]">
            <xsl:call-template name="spaceMaker">
                <xsl:with-param name="levels" select="$ancestors"/>
            </xsl:call-template>
            <xsl:text>  links:&#xA;</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <!-- <NAVTITLE> -->
    <xsl:template match="*[contains(@class, ' topic/navtitle ')
                           and parent::*[contains(@class, ' map/topicmeta ')] 
                           and count(ancestor::*[contains(@class, ' mapgroup-d/topichead ')]) = 1 ]" mode="yaml-toc">
        <xsl:text>&#xA;- title: "</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>"&#xA;</xsl:text>
        <xsl:text>  url: ""&#xA;</xsl:text>
        <xsl:text>  links:&#xA;</xsl:text> 
    </xsl:template>
    
    <!-- <TOPICREF> -->
    <xsl:template match="*[contains(@class, ' map/topicref ')
                           and not(contains(@class, ' mapgroup-d/topicgroup '))
                           and not(contains(@class, ' mapgroup-d/keydef '))
                           and not(contains(@class, ' mapgroup-d/topichead '))]" mode="yaml-toc">
        <xsl:variable name="file" select="replace(@href, '\.dita$', '')"/>
        <xsl:variable name="topic-child" select="child::*[contains(@class, ' map/topicref ')]"/>
        <xsl:variable name="ancestors" select="count(ancestor::*[contains(@class, ' map/topicref ')])"/>
        <xsl:call-template name="spaceMaker">
            <xsl:with-param name="levels" select="$ancestors"/>
        </xsl:call-template>
        <xsl:text>- url: "</xsl:text>
        <xsl:value-of select="replace($file, '^.*/', '')"/>
        <xsl:text>"&#xA;</xsl:text>
        <xsl:choose>
            <xsl:when test="$topic-child">
                <xsl:apply-templates select="*[contains(@class, ' map/topicmeta ')]" mode="yaml-toc"/>
                <xsl:apply-templates select="*[contains(@class, ' map/topicref ')]" mode="yaml-toc"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates mode="yaml-toc"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
        
    <!-- <LINKTEXT> -->
    <xsl:template match="*[contains(@class, ' map/linktext ')]" mode="yaml-toc">
        <xsl:value-of select="normalize-space(.)"/>
    </xsl:template>
    
    <!-- <SHORTDESC> -->
    <xsl:template match="*[contains(@class, ' map/shortdesc ')]" mode="yaml-toc">
        <xsl:value-of select="normalize-space(.)"/>
    </xsl:template>
    
    <!-- <KEYDEF> -->
    <xsl:template match="*[contains(@class, ' map/keydef ')]" mode="yaml-toc"/>
    
    <!-- <RELTABLE> -->
    <xsl:template match="*[contains(@class, ' map/reltable ')]" mode="yaml-toc"/>


    <xsl:template name="spaceMaker">
        <xsl:param name="levels"/>
        <xsl:choose>
            <xsl:when test="$levels gt 1">
                <xsl:variable name="spaces" select="$levels * 4"/>
                <xsl:for-each select="1 to $spaces">
                    <xsl:text>&#x20;</xsl:text>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>    </xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>