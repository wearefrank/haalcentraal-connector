<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" indent="yes" />

    <xsl:template match="/">
        <h1>Data Overview</h1>
        <table class="horizontal-table">
            <tbody>
                <tr>
                    <xsl:for-each select="data/overview/field">

                        <th>
                            <xsl:value-of select="@name" />
                        </th>
                    </xsl:for-each>
                </tr>
                <tr>

                    <xsl:for-each select="data/overview/field">
                        <td>
                            <xsl:value-of select="." />
                        </td>
                    </xsl:for-each>
                </tr>

            </tbody>
        </table>

        <h1>Results Differences</h1>
        <table>
            <thead>
                <tr>
                    <th>Item</th>
                    <th>Difference</th>
                </tr>
            </thead>
            <tbody>
                <xsl:for-each select="data/results/result">
                    <tr>
                        <td>
                            <xsl:value-of select="@item" />
                        </td>
                        <td>
                            <ul>
                                <xsl:for-each select="difference">
                                    <li>
                                        <xsl:value-of select="." />
                                    </li>
                                </xsl:for-each>
                            </ul>
                        </td>
                    </tr>
                </xsl:for-each>
            </tbody>
        </table>
    </xsl:template>
</xsl:stylesheet>