<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- APPLY TOPIC METADATA IN YAML FORMAT -->
    <xsl:template match="*[contains(@class, ' topic/topic ')]" mode="yaml">
        <xsl:text>---&#xA;</xsl:text>
        <xsl:text>topic_type: "</xsl:text>
        <xsl:value-of select="substring-before(@xtrc, ':')"/>
        <xsl:text>"&#xA;</xsl:text>
        <xsl:text>id: "</xsl:text>
        <xsl:value-of select="substring-before(tokenize(@xtrf, '/')[last()], '.')"/>
        <xsl:text>"&#xA;</xsl:text>
        <xsl:text>lang: "</xsl:text>
        <xsl:value-of select="@xml:lang"/>
        <xsl:text>"&#xA;</xsl:text>
        <xsl:text>title: "</xsl:text>
        <xsl:value-of select="normalize-space(child::*[contains(@class, ' topic/title ')])"/>
        <xsl:text>"&#xA;</xsl:text>
        <xsl:text>description: "</xsl:text>
        <xsl:value-of select="normalize-space(descendant::*[contains(@class, ' topic/shortdesc ')])"/>
        <xsl:text>"&#xA;</xsl:text>
        <xsl:apply-templates mode="yaml"/>
        <xsl:text>---&#xA;&#xA;</xsl:text>
    </xsl:template>
    
</xsl:stylesheet>