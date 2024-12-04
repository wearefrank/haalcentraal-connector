<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:param name="expected"/>
    <xsl:param name="actual"/>

    <xsl:output omit-xml-declaration="yes"/>

    <xsl:template match="/">
        <xsl:apply-templates select="$expected/node()">
            <xsl:with-param name="actual" select="$actual"/>
            <xsl:with-param name="path" select="''"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="*">
        <xsl:param name="actual"/>
        <xsl:param name="path"/>
        <xsl:variable name="newPath" select="concat($path, '/', name())"/>
        <xsl:variable name="actualNode" select="$actual/node()[name() = current()/name()]"/>
        <xsl:choose>
            <xsl:when test="not($actualNode)">
                <difference>element [<xsl:value-of select="$newPath"/>] was expected to exist, but could not be found</difference>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="count(@*) != count($actualNode/@*)">
                        <difference>element [<xsl:value-of select="$newPath"/>] was expected to have <xsl:value-of select="count(@*)"/> attribute(s), but actually had <xsl:value-of select="count($actualNode/@*)"/></difference>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="@*">
                            <xsl:with-param name="actual" select="$actualNode"/>
                            <xsl:with-param name="path" select="$newPath"/>
                        </xsl:apply-templates>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test="count(*) != count($actualNode/*)">
                        <difference>element [<xsl:value-of select="$newPath"/>] was expected to have <xsl:value-of select="count(*)"/> child element(s), but actually had <xsl:value-of select="count($actualNode/*)"/></difference>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="*">
                            <xsl:with-param name="actual" select="$actualNode"/>
                            <xsl:with-param name="path" select="$newPath"/>
                        </xsl:apply-templates>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test="count(text()) != count($actualNode/text())">
                        <difference>element [<xsl:value-of select="$newPath"/>] was expected to have <xsl:value-of select="count(text())"/> text node(s), but actually had <xsl:value-of select="count($actualNode/text())"/></difference>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="text()">
                            <xsl:with-param name="actual" select="$actualNode"/>
                            <xsl:with-param name="path" select="$newPath"/>
                        </xsl:apply-templates>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="@*">
        <xsl:param name="actual"/>
        <xsl:param name="path"/>
        <xsl:variable name="newPath" select="concat($path, '/@', name())"/>
        <xsl:variable name="actualNode" select="$actual/@*[name() = current()/name()]"/>
        <xsl:if test=". != $actualNode">
            <difference>attribute [<xsl:value-of select="$newPath"/>] was expected to have text [<xsl:value-of select="."/>], but actually had text [<xsl:value-of select="$actualNode"/>]</difference>
        </xsl:if>
    </xsl:template>

    <xsl:template match="text()">
        <xsl:param name="actual"/>
        <xsl:param name="path"/>
        <xsl:variable name="position" select="position()"/>
        <xsl:variable name="newPath" select="concat($path, '/text()[', $position, ']')"/>
        <xsl:variable name="actualNode" select="$actual/text()[$position]"/>
        <xsl:if test=". != $actualNode">
            <difference>element [<xsl:value-of select="$newPath"/>] was expected to have text [<xsl:value-of select="."/>], but actually had text [<xsl:value-of select="$actualNode"/>]</difference>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>