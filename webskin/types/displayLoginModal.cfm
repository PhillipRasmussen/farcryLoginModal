<cfsetting enablecfoutputonly="true">
<!--- @@allowredirect: 0 --->

<cfimport taglib="/farcry/core/tags/admin" prefix="admin" />
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />
<cfparam name="stParam.bodyInclude" default="">
<cfset request.fc.bShowTray = false />
<skin:view typename="dmHTML" webskin="webtopHeaderModal" bIgnoreSecurity="true" />

<cfif application.security.isLoggedIn()>
<cfoutput>
<script type="text/javascript">
$j(function(){
		parent.$j('##fcLoginModal').modal('hide');
});
	</script>
</cfoutput>
<cfelse>
<skin:view typename="farLogin" webskin="displayLogin" bIgnoreSecurity="true"/>
</cfif>
<cfoutput>
</body>
</html>
</cfoutput>


<cfsetting enablecfoutputonly="false">