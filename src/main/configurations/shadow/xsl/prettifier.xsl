<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <xsl:output method="html" indent="yes" />

    <xsl:template match="/">
        <html>
            <head>
                <title>Results Differences</title>
                <style>
                    table { border-collapse: collapse; width: 100%; }
                    th, td { border: 1px solid black; padding: 8px; text-align: left; }
                    th { background-color: #f2f2f2; }
                </style>
            </head>
            <body>
                <h1>Results Differences</h1>
                <table>
                    <thead>
                        <tr>
                            <th>Item</th>
                            <th>Difference</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each select="results/result">
                            <tr>
                                <td><xsl:value-of select="@item" /></td>
                                <td>
                                    <ul>
                                        <xsl:for-each select="difference">
                                            <li><xsl:value-of select="." /></li>
                                        </xsl:for-each>
                                    </ul>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
