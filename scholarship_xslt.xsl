<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
	xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xs tei" version="2.0">
	
	<!-- script for converting XML-TEI to HTML. 		
	00-began with fork from /xslt/masters/HTMLtransform.xsl
	01-filled master with needed code
	02-revised plays, simplified by eliminating TOC
	03-working with the XSLT group
	04-working with the XSLT group
-->

	<!-- Here is the document declaration necessary for an HTML (web) page -->

	<xsl:output method="html" doctype-system="about:legacy-compat"
		omit-xml-declaration="yes" indent="yes" encoding="UTF-8"/>
	<xsl:strip-space elements="*"/>

	<!-- Choices -->
	<xsl:param name="cssFile">../../css/digEd_scholarship.css</xsl:param>
	<xsl:param name="autoPageNum" select="True"/>
	<xsl:param name="pageImgURL"></xsl:param>
	
	<!-- running multiple documents via a list 

	<xsl:template match="list">
		<xsl:for-each select="item">
			<xsl:apply-templates select="document(@code)/TEI">
				<xsl:with-param name="xpathFilename" select="@code"/>
			</xsl:apply-templates>
		</xsl:for-each>
	</xsl:template> -->

	<!--structuring the document-->

	<xsl:template match="TEI">
		<!-- <xsl:param name="xpathFilename"/>
		<xsl:variable name="Filename">
			<xsl:value-of select="substring-before($xpathFilename, '.xml')"/>
		</xsl:variable>
		 <xsl:result-document href="../HTML/{$Filename}.html"> -->
			<html>
				<xsl:comment>THIS FILE IS GENERATED FROM AN XML MASTER. DO NOT EDIT</xsl:comment>
				<head>
					<xsl:apply-templates select="teiHeader"/>
				</head>
				<body>
					<xsl:apply-templates select="text"/>
					<!-- We are placing all the notes at the end.  Template match="note" will tell what to do with the notes 
						as they appear in the "text", but template match="note"MODE='END', as here, will tell what to do with 
						the notes as they appear at the end of the document. -->
					<xsl:apply-templates select="//note" mode="end"/>
					<!-- We need all these returns so that, when a note number in the text is clicked on, the browser will take 
						you to that note AND PUT IT AT THE TOP OF THE SCREEN. Otherwise, it doesn't look as if the browswer really 
						took you to that note.  -->
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
				</body>
			</html>
		<!-- </xsl:result-document> -->
	</xsl:template>

	<!-- =======================================================
	 Putting the teiHeader info. into the html head element -->

	<xsl:template match="teiHeader">
		<title>
			<xsl:value-of select="fileDesc/titleStmt/title"/>
		</title>
		<link rel="stylesheet" type="text/css" href="{$cssFile}"/>
	</xsl:template>

	<!-- =======================================================
	   front templates -->
	
	<xsl:template match="front">
		<xsl:apply-templates/>
		<hr />
	</xsl:template>

	<xsl:template match="titlePart">
		<xsl:choose>
		<xsl:when test="@type = 'main'">
		<h1 class="center">
			<xsl:apply-templates/>
		</h1>
		</xsl:when>
		<xsl:when test="@type = 'sub1'">
			<h2 class="center">
				<xsl:apply-templates/>
			</h2>
		</xsl:when>
		<xsl:when test="@type = 'sub2'">
			<h3 class="center">
				<xsl:apply-templates/>
			</h3>
		</xsl:when>
			<xsl:when test="@type = 'sub3'">
				<h3 class="center">
					<xsl:apply-templates/>
				</h3>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="titlePage/byline">
		<h3 class="center">
			<xsl:apply-templates/>
		</h3>
	</xsl:template>

	<xsl:template match="docDate">
		<h4>
			<xsl:apply-templates/>
		</h4>
	</xsl:template>
	
	<xsl:template match="docImprint">
		<p class="center"><xsl:text>Published by </xsl:text>
			<xsl:apply-templates select="publisher"/>
			<xsl:if test="date">
				<xsl:text>, </xsl:text>
				<xsl:apply-templates select="date"/>
			</xsl:if>
		</p>
	</xsl:template>
	
	<xsl:template match="docImprint/date">
		<xsl:apply-templates/>
		<!--<xsl:value-of select="format-date(., '[MNn] [Y]')"/> -->
	</xsl:template>
	
	<xsl:template match="docEdition">
		<p><xsl:text>Vol. </xsl:text>
			<xsl:value-of select="bibl/biblScope[@unit='volume']"/>
			<xsl:text>, </xsl:text>
			<xsl:text>pp. </xsl:text><xsl:value-of select="bibl/biblScope[@unit='page']"/>
		</p>
	</xsl:template>

	<xsl:template match="castList">
		<div id="castList">
			<h5>
				<xsl:value-of select="head"/>
			</h5>
			<ul>
				<xsl:apply-templates select="castItem | castGroup"/>
			</ul>
		</div>
	</xsl:template>

	<xsl:template match="castItem | castGroup">
		<li>
			<xsl:choose>
				<xsl:when test="head">
					<xsl:value-of select="head"/>
				</xsl:when>
				<xsl:when test="role">
					<xsl:value-of select="role"/>
				</xsl:when>
			</xsl:choose>
			<xsl:if test="roleDesc">
				<xsl:text>: </xsl:text>
				<xsl:value-of select="roleDesc"/>
			</xsl:if>
		</li>
	</xsl:template>


	<!--===================================================
	         body templates used by all types of documents -->

	<xsl:template match="text">
		<xsl:variable name="id" select="preceding-sibling::teiHeader/fileDesc/publicationStmt/idno[@type='local']"/>
		<!-- <xsl:variable name="id" select="preceding-sibling::teiHeader/fileDesc/titleStmt/title[@type='main']"/> -->
		<!-- THIS MEANS OF NAMING MY XML FILE DOES NOT CURRENTLY WORK WITH HOW MY XML IS ENCODED -->
		<p class="floatRight"><a href="../../XML/{$id}.xml"><img src="../../images/tei.gif" alt="The TEI Version"/></a></p>
		
		<xsl:choose>
			<xsl:when test="front">
				<xsl:apply-templates select="front"/>
			</xsl:when>
			
			<xsl:otherwise>
		<h2>
			<xsl:value-of
				select="ancestor-or-self::TEI/teiHeader/fileDesc/titleStmt/title"/>
		</h2>
		<h3>
			<xsl:value-of
				select="ancestor-or-self::TEI/teiHeader/fileDesc/titleStmt/author"/>
		</h3>
		<hr/>
			</xsl:otherwise>
		</xsl:choose>
		
		<xsl:apply-templates select="body"/>
	</xsl:template>

	<xsl:template match="head">
		<h4 class="center">
			<xsl:apply-templates/>
		</h4>
	</xsl:template>

	<xsl:template match="byline">
		<h5>
			<xsl:apply-templates/>
		</h5>
	</xsl:template>

	<xsl:template match="lg">
		<table>
			<xsl:apply-templates/>
		</table>
	</xsl:template>
	
	<xsl:template match="epigraph[@rend='poem']">
		<table class="epigraph">
			<xsl:apply-templates/>
		</table>
	</xsl:template>
	

	<xsl:template match="epigraph[@rend='prose']">
		<p class="epigraph">
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	
	<xsl:template match="q">
		<xsl:text>&quot;</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&quot;</xsl:text>
	</xsl:template>

	<xsl:template match="bibl[@type = 'epigraph']">
		<p class="epigCite">
			<xsl:apply-templates/>
		</p>
	</xsl:template>

	<xsl:template match="l">
		<tr>
			<td>
				<xsl:attribute name="class">a</xsl:attribute>
				<span>
					<xsl:attribute name="class">
						<xsl:value-of select="@rend"/>
					</xsl:attribute>
					<xsl:apply-templates/>
				</span>
			</td>
			<td>
				<xsl:attribute name="class">b</xsl:attribute>
				<xsl:attribute name="align">right</xsl:attribute>
				<xsl:number from="div" level="any"/>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="p">
		<p>
			<xsl:apply-templates/>
		</p></xsl:template>

	<xsl:template match="title | hi[@rend = 'italic'] | emph">
		<em>
			<xsl:value-of select="."/>
		</em>
	</xsl:template>
	
	<!-- Added this bolded text -->
	<xsl:template match="hi[@rend = 'bold']">
		<b>
			<xsl:value-of select="."/>
		</b>
	</xsl:template>
	
	<xsl:template match="anchor">
		<a name="{@xml:id}"/>
	</xsl:template>

	<xsl:template match="ref">
		<a href="#{@target}">
			<xsl:apply-templates/>
		</a>
	</xsl:template>

	<xsl:template match="figure/head">
		<h3>
			<xsl:apply-templates/>
		</h3>
	</xsl:template>

	<xsl:template match="graphic">
		<xsl:variable name="imageURL">
			<xsl:value-of select="concat('../images/', substring-after(@url, 'image'), '.jpg')"/>
		</xsl:variable>
		<img src="{$imageURL}" alt="a picture of {preceding-sibling::head}"/>
	</xsl:template>

	<xsl:template match="figDesc">
		<p>
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	
	<xsl:template match="fw">
		<xsl:choose>
			<xsl:when test="parent::p and @type = 'catch'">
				<xsl:text disable-output-escaping="yes"><![CDATA[</p>]]></xsl:text>
				<p>
					<span class="right">
						<xsl:value-of select="."/>
					</span>
				</p>
				<xsl:text disable-output-escaping="yes"><![CDATA[<p>]]></xsl:text>
			</xsl:when>
			<xsl:when test="parent::p and @type = 'pageNum' or @type='sig'">
				<xsl:text disable-output-escaping="yes"><![CDATA[</p>]]></xsl:text>
				<p>
					<span class="sig_center">
						<xsl:value-of select="."/>
					</span>
				</p>
				<xsl:text disable-output-escaping="yes"><![CDATA[<p>]]></xsl:text>
			</xsl:when>
			<xsl:when test="parent::p and @type = 'sig'">
				<xsl:text disable-output-escaping="yes"><![CDATA[</table>]]></xsl:text>
				<span class="sig_center">
					<xsl:value-of select="."/>
				</span>
				<xsl:text disable-output-escaping="yes"><![CDATA[<table>]]></xsl:text>
			</xsl:when>
			<xsl:when test="parent::lg and @type = 'catch'">
				<xsl:text disable-output-escaping="yes"><![CDATA[</table>]]></xsl:text>
				<span class="right">
					<xsl:value-of select="."/>
				</span>
				<xsl:text disable-output-escaping="yes"><![CDATA[<table>]]></xsl:text>
			</xsl:when>
			<xsl:when test="parent::lg and @type = 'pageNum' or @type='sig'">
				<xsl:text disable-output-escaping="yes"><![CDATA[</p>]]></xsl:text>
				<p>
					<span class="sig_center">
						<xsl:value-of select="."/>
					</span>
				</p>
				<xsl:text disable-output-escaping="yes"><![CDATA[<p>]]></xsl:text>
			</xsl:when>
			<xsl:when test="parent::lg and @type = 'sig'">
				<xsl:text disable-output-escaping="yes"><![CDATA[</table>]]></xsl:text>
				<span class="sig_center">
					<xsl:value-of select="."/>
				</span>
				<xsl:text disable-output-escaping="yes"><![CDATA[<table>]]></xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

		<xsl:template match="pb">
			<br/>
			<a name="{@xml:id}"/>
			<!-- Added this if statement as it was in the original page numbering schema below and might impact
			how the notes work.-->
			<xsl:if test="preceding-sibling::pb/following-sibling::note[@place = 'pageBottom']">
				<xsl:apply-templates select="preceding-sibling::pb/following-sibling::note[@place = 'pageBottom']"/>
			</xsl:if>
		</xsl:template>
	<!-- Replaced the more complex auto page numbering schema, not necessary for my scholarship which has set pagination, with this match that creates an achor for each page.-->
		<!--<xsl:choose>
			<xsl:when test="$autoPageNum = 'True'">
				<xsl:variable name="fullPageImgURL">
					<xsl:value-of select="$pageImgURL"/>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="parent::p">
						<xsl:text disable-output-escaping="yes"><![CDATA[</p>]]></xsl:text>
						<p>
							<a href="{$fullPageImgURL}">
								<img class="pgImg" src="../images/pageimage.gif" alt="page image"/>
							</a>
							<span class="pageNum">
								<xsl:text>[Page </xsl:text>
								<xsl:value-of select="@n"/>
								<xsl:text>]</xsl:text>
							</span>
						</p>
						<xsl:text disable-output-escaping="yes"><![CDATA[<p>]]></xsl:text>
					</xsl:when>
					<xsl:when test="parent::lg">
						<xsl:text disable-output-escaping="yes"><![CDATA[</table>]]></xsl:text>
						<p>
							<a href="{$fullPageImgURL}">
								<img class="pgImg" src="../images/pageimage.gif" alt="page image"/>
							</a>
							<span class="right">
								<xsl:text>[Page </xsl:text>
								<xsl:value-of select="@n"/>
								<xsl:text>]</xsl:text>
							</span>
						</p>
						<xsl:text disable-output-escaping="yes"><![CDATA[<table>]]></xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<p>
							<a href="{$fullPageImgURL}">
								<img class="pgImg" src="../images/pageimage.gif" alt="page image"/>
							</a>
							<span class="right">
								<xsl:text>[Page </xsl:text>
								<xsl:value-of select="@n"/>
								<xsl:text>]</xsl:text>
							</span>
						</p>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
		<xsl:if test="preceding-sibling::pb/following-sibling::note[@place = 'pageBottom']">
			<xsl:apply-templates select="preceding-sibling::pb/following-sibling::note[@place = 'pageBottom']"/>
		</xsl:if> -->
	

	<!-- =======================================================
	    body templates used by different types of documents -->

	<xsl:template match="stage">
		<xsl:choose>
			<xsl:when test="parent::l">
				<br/>
				<span class="stage">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<p class="stage">
					<xsl:apply-templates/>
				</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

<!--Consider adding a conditional if statement here. If there is no speaker tag in the sp, then add <xsl:text>     </xsl:text>-->
	<xsl:template match="sp">
		<p>
			<span class="sp">
				<table width="100%">
					<tr>
						<td width="20%" valign="top">
							<em><xsl:value-of select="speaker"/></em></td>
						<td><xsl:apply-templates select="lg/l | l | p"/></td></tr>
				</table>
			</span>
		</p>
		</xsl:template>

	<xsl:template match="salute | signed">
		<p>
			<xsl:if test="@rend">
				<xsl:attribute name="class">
					<xsl:value-of select="@rend"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates/>
		</p>
	</xsl:template>


	<!-- =======================================================
	  Divs for different types of documents -->
	
	<!-- poems, coded with 'poemBody' div tag -->
	

	<xsl:template match="div[@type = 'poemBody']">
		<table>
			<xsl:apply-templates select="lg"/>
		</table>
	</xsl:template>
	
	<!-- for plays -->
	
	<!-- for scholarship -->
	<xsl:template match="div">
		<xsl:apply-templates/>
		<hr />
	</xsl:template>
	
	<!-- preserving the line breaks -->
	<xsl:template match="lb">
		<xsl:apply-templates/>
		<br/>
	</xsl:template>
		

	<!-- =======================================================
	   notes -->

	<xsl:template match="tei:note">
		<xsl:variable name="noteNBR">
			<xsl:number select="." level="any"/>
		</xsl:variable>
		<a>
			<xsl:attribute name="href">
				<xsl:text>#</xsl:text>
				<xsl:value-of select="$noteNBR"/>
			</xsl:attribute>
			<xsl:attribute name="id" select="concat('back', $noteNBR)"/>
			<sup>
				<xsl:value-of select="$noteNBR"/>
			</sup>
		</a>
		<xsl:text> </xsl:text>
	</xsl:template>
	
	<xsl:template match="tei:note" mode="end">
		<xsl:variable name="noteNBR">
			<xsl:number select="." level="any"/>
		</xsl:variable>
		<p class="note" id="{$noteNBR}">
			<xsl:value-of select="$noteNBR"/><xsl:text>.&#160;&#160;</xsl:text>
			<xsl:apply-templates/>
			<xsl:text> </xsl:text>
			<a>
				<xsl:attribute name="href"><xsl:text>#back</xsl:text><xsl:value-of select="$noteNBR"
				/></xsl:attribute>
				<xsl:text>Back</xsl:text>
			</a>
		</p>
	</xsl:template>
	
	<!-- Indices -->
	<!-- I have ignored all the auto page numbering from this XSLT by selecting "false" for auto page numbering in the params, as my page numbers are static. I need assign each page
		with the xml:id I assigned in my XML. Then I can use the xml:id to create the html <a href> link to that particular page.
		</xsl:template>
		-->
	<!--Formatting the indices -->
	<xsl:template match="label">
		<p>
			<h2><xsl:apply-templates/>
				<br/>
			</h2>
		</p>
	</xsl:template>	
	
	<xsl:template match="list/item">
		<xsl:apply-templates/>
		<br/>
	</xsl:template>

	<!-- Works List formatting -->
	<!-- This works, but want to organize the formatting based on the title tags. Put on backburner and possibly remove.
	<xsl:template match="listBibl/bibl/date">
		<xsl:apply-templates/>
			<xsl:text>  </xsl:text>
	</xsl:template> -->
	
	<xsl:template match="listBibl/bibl">
		<xsl:apply-templates/>
		<br/>
	</xsl:template>
	
	<xsl:template match="listBibl/bibl/title">
		<xsl:text>  </xsl:text>
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="listBibl/bibl/pubPlace">
		<xsl:text>  </xsl:text>
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="listBibl/bibl/publisher">
		<xsl:text>  </xsl:text>
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="listBibl/bibl/note">
		<xsl:text>  </xsl:text>
		<xsl:apply-templates/>
	</xsl:template>
	
<!-- Bibliography formatting for Cederstrom thesis -->
	<xsl:template match="div [@type = 'bibliography']/listBibl/bibl/title">
		<xsl:apply-templates/>
		<br/>
	</xsl:template>
	
	<xsl:template match="div [@type = 'bibliography']/listBibl/biblStruct/monogr/author">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="div [@type = 'bibliography']/listBibl/biblStruct/monogr/title">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="div [@type = 'bibliography']/listBibl/biblStruct/monogr/imprint/pubPlace">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="div [@type = 'bibliography']/listBibl/biblStruct/monogr/imprint/date">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="div [@type = 'bibliography']/listBibl/biblStruct/monogr/imprint/note">
		<xsl:apply-templates/>
		<br/>
	</xsl:template>
	
<!-- This centers the words on the facsimile title page. -->
	<!-- Tried using "span center" across all of this, but did not work. Perhaps add center class to <p> tags? -->
	<xsl:template match="div[@type = 'title_page_facsimile']">
		<div class="center">
			<div>
			<xsl:apply-templates/>
		</div>
		</div>	
	</xsl:template>

<!-- This adjust the margins of Gildon's epistle to Defoe -->
	<xsl:template match="div[@type = 'epistle'] | div[@type = 'postscript']">
		<div class="epistle">
			<div>
				<xsl:apply-templates/>
			</div>
		</div>	
	</xsl:template>

</xsl:stylesheet>
