<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <xsl:element name="tree">
            <xsl:for-each select="Tree/tree">
                <xsl:element name="tree">
                    <xsl:attribute name="text">
                        <xsl:value-of select="LAYER_NAME"/>
                    </xsl:attribute>
                    <xsl:attribute name="target">tablelist_frame</xsl:attribute>
                    <xsl:attribute name="src">../metamanage/createLayerTreeXml.jsp?layer_id=<xsl:value-of select="LAYER_ID"/>
                    </xsl:attribute>
                    <xsl:attribute name="action">javascript:getMenu('<xsl:value-of select="LAYER_NAME"/>', '<xsl:value-of
                            select="LAYER_ID"/>')
                    </xsl:attribute>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>