<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- THIS PLUGIN EXTENDS org.lwdita DITA-TO-MARKDOWN -->
    <xsl:import href="plugin:org.lwdita:xsl/dita2markdown_github.xsl"/>
    <dita:extension id="dita.xsl.markdown" 
                    behavior="org.dita.dost.platform.ImportXSLAction"
                    xmlns:dita="http://dita-ot.sourceforge.net"/>
    
    <xsl:include href="dita2dacad-npmImpl.xsl"/>

</xsl:stylesheet>