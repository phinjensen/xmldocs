<?xml version='1.0'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:import href="http://docbook.sourceforge.net/release/xsl/current/xhtml/chunk.xsl"/>
	<!-- <xsl:import href="/usr/share/xml/docbook/stylesheet/nwalsh/xhtml/chunk.xsl"/> -->
	
	<!-- This section here till I find out how to pick this
	information from a catalog -->

	<xsl:param name="html.stylesheet">../xmldocs.css</xsl:param>

	<xsl:param name="admon.graphics.path">../images/</xsl:param>
	<xsl:param name="navig.graphics.path">../images/</xsl:param>
	<xsl:param name="callout.graphics.path">../images/</xsl:param>

	<xsl:param name="use.id.as.filename"/>
	<xsl:param name="root.filename">index</xsl:param>
	<xsl:param name="chunk.fast">0</xsl:param>
	<xsl:param name="chunk.quietly">1</xsl:param>
	<xsl:param name="chunk.section.depth">1</xsl:param>
	<xsl:param name="chunk.first.sections">1</xsl:param>
	<xsl:param name="chunker.output.encoding" select="'ISO-8859-1'" />
	<xsl:param name="chunker.output.indent">yes</xsl:param>

	
	<!-- a parameter added to docbook after my inquiry. Will have no
	  effect on xsl 1.68.1, but for 1.69.1 and newer will keep the
	  old behavior - suppress <refclass> elements from output.
		http://sourceforge.net/tracker/index.php?func=detail&aid=1461065&group_id=21935&atid=373750
		-->
	<xsl:param name="refclass.suppress">1</xsl:param>



	<!-- insert [restrict] [/restrict] into documents for online
		viewing -->
	<xsl:template name="user.header.content">
		<xsl:comment>[restrict log='none']</xsl:comment>
	</xsl:template>
	<xsl:template name="user.footer.content">
		<xsl:comment>[/restrict]</xsl:comment>
  <p class='w3c'>
    <a href="http://www.docbook.org/">
      <img
        src="../images/docbook.png"
        alt="DocBook!"
        class='w3cimg'/>
    </a>
    <a href="http://www.icdevgroup.org/">
      <img
        src="../images/bb_interchange.png"
        alt="Interchange!"
        class='w3cimg'/>
    </a>
  </p>
	</xsl:template>


	<!-- Norman Walsh gave me a nice idea and code. Since chunked documents
		need ../ prefix in relative links, add it with XSL. And boy, here's 
		the winner! ;-) -->
	<xsl:template match="ulink" name="ulink">
		<xsl:variable name="link">
			<a>
				<xsl:if test="@id">
					<xsl:attribute name="name">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:attribute name="href">
		<xsl:if test="starts-with(@url, 'files/')">../</xsl:if>
		<xsl:value-of select="@url"/>
				</xsl:attribute>
				<xsl:if test="$ulink.target != ''">
					<xsl:attribute name="target">
						<xsl:value-of select="$ulink.target"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="count(child::node())=0">
						<xsl:value-of select="@url"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates/>
					</xsl:otherwise>
				</xsl:choose>
			</a>
		</xsl:variable>
		<!--
		<xsl:choose>
			<xsl:when test="function-available('suwl:unwrapLinks')">
				<xsl:copy-of select="suwl:unwrapLinks($link)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="$link"/>
			</xsl:otherwise>
		</xsl:choose>
		-->
		<xsl:copy-of select="$link"/>
	</xsl:template>



  <!-- works only for this stylesheet, should be modified for others -->
  <xsl:template match="varname">
				<xsl:variable name="input" select="."/>
        <xsl:text disable-output-escaping="yes">&lt;code class="varname"&gt;</xsl:text>
        <xsl:text disable-output-escaping="yes">&lt;a href="../vars/</xsl:text>
        <xsl:value-of select="$input" />
        <xsl:text disable-output-escaping="yes">.html"&gt;</xsl:text>
        <xsl:value-of select="$input" />
        <xsl:text disable-output-escaping="yes">&lt;/a&gt;</xsl:text>
        <xsl:text disable-output-escaping="yes">&lt;/code&gt;</xsl:text>
  </xsl:template>
  <xsl:template match="option">
				<xsl:variable name="input" select="."/>
        <xsl:text disable-output-escaping="yes">&lt;code class="option"&gt;</xsl:text>
        <xsl:text disable-output-escaping="yes">&lt;a href="../confs/</xsl:text>
        <xsl:value-of select="$input" />
        <xsl:text disable-output-escaping="yes">.html"&gt;</xsl:text>
        <xsl:value-of select="$input" />
        <xsl:text disable-output-escaping="yes">&lt;/a&gt;</xsl:text>
        <xsl:text disable-output-escaping="yes">&lt;/code&gt;</xsl:text>
  </xsl:template>
  <xsl:template match="tag">
				<xsl:variable name="input" select="."/>
        <xsl:text disable-output-escaping="yes">&lt;code class="tag"&gt;</xsl:text>
        <xsl:text disable-output-escaping="yes">[&lt;a href="../tags/</xsl:text>
        <xsl:value-of select="$input" />
        <xsl:text disable-output-escaping="yes">.html"&gt;</xsl:text>
        <xsl:value-of select="$input" />
        <xsl:text disable-output-escaping="yes">&lt;/a&gt;</xsl:text>
        <xsl:text disable-output-escaping="yes">&lt;/code&gt;] </xsl:text>
  </xsl:template>
  <xsl:template match="pragma">
				<xsl:variable name="input" select="."/>
        <xsl:text disable-output-escaping="yes">&lt;code class="pragma"&gt;</xsl:text>
        <xsl:text disable-output-escaping="yes">&lt;a href="../pragmas/</xsl:text>
        <xsl:value-of select="$input" />
        <xsl:text disable-output-escaping="yes">.html"&gt;</xsl:text>
        <xsl:value-of select="$input" />
        <xsl:text disable-output-escaping="yes">&lt;/a&gt;</xsl:text>
        <xsl:text disable-output-escaping="yes">&lt;/code&gt;</xsl:text>
  </xsl:template>
  <xsl:template match="check">
				<xsl:variable name="input" select="."/>
        <xsl:text disable-output-escaping="yes">&lt;code class="check"&gt;</xsl:text>
        <xsl:text disable-output-escaping="yes">&lt;a href="../orderchecks/</xsl:text>
        <xsl:value-of select="$input" />
        <xsl:text disable-output-escaping="yes">.html"&gt;</xsl:text>
        <xsl:value-of select="$input" />
        <xsl:text disable-output-escaping="yes">&lt;/a&gt;</xsl:text>
        <xsl:text disable-output-escaping="yes">&lt;/code&gt;</xsl:text>
  </xsl:template>
  <xsl:template match="widget">
				<xsl:variable name="input" select="."/>
        <xsl:text disable-output-escaping="yes">&lt;code class="widget"&gt;</xsl:text>
        <xsl:text disable-output-escaping="yes">&lt;a href="../widgets/</xsl:text>
        <xsl:value-of select="$input" />
        <xsl:text disable-output-escaping="yes">.html"&gt;</xsl:text>
        <xsl:value-of select="$input" />
        <xsl:text disable-output-escaping="yes">&lt;/a&gt;</xsl:text>
        <xsl:text disable-output-escaping="yes">&lt;/code&gt;</xsl:text>
  </xsl:template>
  <xsl:template match="filter">
				<xsl:variable name="input" select="."/>
        <xsl:text disable-output-escaping="yes">&lt;code class="filter"&gt;</xsl:text>
        <xsl:text disable-output-escaping="yes">&lt;a href="../filters/</xsl:text>
        <xsl:value-of select="$input" />
        <xsl:text disable-output-escaping="yes">.html"&gt;</xsl:text>
        <xsl:value-of select="$input" />
        <xsl:text disable-output-escaping="yes">&lt;/a&gt;</xsl:text>
        <xsl:text disable-output-escaping="yes">&lt;/code&gt;</xsl:text>
  </xsl:template>



	<!-- This chunk inserts <meta name="area" content="REFENTRY_GROUP" />,
	     to help Swish index documentation properly. Thanks Scott Hudson.  -->
	<xsl:template match="refclass[1]">
		<xsl:variable name="area">
		<xsl:value-of select="." />
		</xsl:variable>

		<xsl:text disable-output-escaping="yes">&lt;meta name="area" content="</xsl:text>
		<xsl:value-of select="$area" />
		<xsl:text disable-output-escaping="yes">" /&gt;</xsl:text>
	</xsl:template>



	<!-- This chunk inserts <meta name="purpose" content="PURPOSE_LINE" />,
	     to help Swish index documentation properly. -->
	<xsl:template match="refpurpose[1]">
		<xsl:text> </xsl:text>
		<xsl:call-template name="dingbat">
			<xsl:with-param name="dingbat">em-dash</xsl:with-param>
		</xsl:call-template> 
		<xsl:text> </xsl:text>
		<xsl:apply-templates/>

		<xsl:variable name="purpose">
		<xsl:value-of select="." />
		</xsl:variable>

		<xsl:text disable-output-escaping="yes">&lt;meta name="purpose" content="</xsl:text>
		<xsl:value-of select="$purpose" />
		<xsl:text disable-output-escaping="yes">" /&gt;</xsl:text>
	</xsl:template>

	<xsl:include href="common.xsl"/>
	<xsl:include href="html-common.xsl"/>


</xsl:stylesheet>

