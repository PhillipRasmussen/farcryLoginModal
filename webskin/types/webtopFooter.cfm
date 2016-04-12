<cfsetting enablecfoutputonly="true">

<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<cfoutput>
				</div>
			</div>
		</div>

		<div class="farcry-footer container-fluid">
			<div class="row-fluid">
				<div class="span12">
					Copyright &copy; <a href="http://www.daemon.com.au" target="_blank">Daemon</a> 1997-#year(now())#. #application.sysInfo.farcryVersionTagLine#
				</div>
			</div>
		</div>

		<script type="text/javascript">
		
// *********************************** Form Login Modal ***************************************** //
		$j(function(){
			var interval = 60000 * .1; // .1 of minute (ie 6sec)			
			var ajax_call = function() { // this will test if currently logged in or not
 			 //console.log('call done');
			 $j.ajax({
			url			: "#application.fapi.getLink(type=stObj.typename,objectid=stObj.objectid,view='displayIsLoggedIn',urlParameters='ajaxmode=1')#",
			
			type		: "POST",
			success		: function(data){
							//console.log('result:'+data);
							if (data) {
								//console.log('logged in - do not show login modal');
							} else {
								//console.log('Not logged in - show login modal');
								showLoginModal();								
							};
						  },
			dataType	: "json",
			cache:false
		});
			 
			};
			
		var intervalID = setInterval(ajax_call, interval);// this starts the testing every so many seconds bassed on interval
		var showLoginModal = function(){ 
		openBootstrapLoginModal({ 
				title : "Are you still there? Your session has timed out.",
				url : "#application.url.webtop#/index.cfm?type=farQueueTask&view=displayLoginModal",
				onHidden: function() {intervalID = setInterval(ajax_call, interval);return true;},
				onShown: function() {
					clearInterval(intervalID);					
					return true;}
			});
			
		};
		
		var openBootstrapLoginModal = function($settings){
		$settings = $j.extend({
			keyboard: false,
			backdrop: 'static',
			width: $j(window).width() - 40,
			height: $j(window).height() - 40,
			title: 'Administration',
			url: '',
			onShown: function() {
				return true;
			},
			onHidden: function() {
				window.location.href = window.location.href.split('##')[0];
				return true;
			}
		}, $settings);
		var modalLeftPos = 0; 
		var fcModalTPL = $j("<div id='fcLoginModal' class='modal hide fade fc-modal' style='z-index: 70000;' tabindex='-1' role='dialog' aria-labelledby='fcLoginModalLabel' aria-hidden='true'><div class='modal-header'><button type='button' class='close' data-dismiss='modal' aria-hidden='true'>&times;</button><h3 id='fcLoginModalLabel'>Modal</h3></div><div class='modal-body' style='width: auto;min-height: 0px;max-height:900px;height: 455px;position: relative;border: 0;padding: 0;background: 0;-webkit-overflow-scrolling:touch;overflow: auto;zoom: 1;'><iframe style='width: 100%;height: 99%;border-width: 0px;margin: 0;padding: 0;' frameborder='0'></iframe></div></div>");
		var $fcModal = $j("##fcLoginModal");
		if($fcModal.length == 0) {
			$j("body").append(fcModalTPL);
		}
		
		$j('##fcLoginModalLabel',$j('##fcLoginModal')).html($settings.title);
		
		
		$j('##fcLoginModal').css('top', '15px');
		$j('##fcLoginModal').css('margin-left', '0px');
		$j('##fcLoginModal').css('max-height', $settings.height);
		
		$j('##fcLoginModal').css('height', $settings.height);
		$j('.modal-body').css('max-height', $settings.height);
		$j('##fcLoginModal').css('width', $settings.width);
		$j('.modal-body').css('max-width', $settings.width);
		
		$j('.modal-body',$j('##fcLoginModal')).css('height', $settings.height - 36);
	
	 	modalLeftPos = ( $j(window).width() - $j('##fcLoginModal').width() ) / 2;
		$j('##fcLoginModal').css('left', modalLeftPos);
	
	
		$j('##fcLoginModal').off("shown").on('shown', function () {
			
			if ( $settings.url.indexOf("?") < 0 ) { $settings.url = $settings.url + '?' };
			$settings.url=$settings.url + '&dialogID=fcLoginModal'
			$j('iframe',$j('##fcLoginModal')).attr('src',$settings.url);
			
			$j("html").css('overflow', 'hidden');
			$settings.onShown();
			
		}).off("hidden").on('hidden', function () {
			$j("html").css('overflow', 'auto');
			$j('iframe',$j('##fcLoginModal')).attr('src','');
			$settings.onHidden();			
		}).modal({
			keyboard: $settings.keyboard,
			backdrop: $settings.backdrop
			
		});
	}; // END openBootstrapLoginModal()
			
			
		
		
		
		}); // end on jquery load
// *********************************** Form Login Modal END ***************************************** //		
		$j(function(){
			
			
			
			
			
			
			
			
			
			/* fix for https://github.com/twitter/bootstrap/pull/7211 */
			$j(document).off("click.dropdown-menu").on("click.dropdown-menu",function(e){ if (e.which===1) e.stopPropagation(); });
			
			/* enable bootstrap menus to work on hover */
			$j(".farcry-secondary-nav .nav:first > li.dropdown").hover(function(){
				clearTimeout($j.data(this, "timer"));
				$j(document).off("mousemove.menu");
				$j("li.open").removeClass("open");
				$j(this).addClass("open");
			}, function(){
				var dropdown = this, self = $j(this), megamenu = self.find(".dropdown-mega-menu"), menupos = megamenu.offset(), buffer = 60;
				
				$j.data(this, "timer", setTimeout(function() {
					self.removeClass("open");
					$j(document).off("mousemove.menu");
				}, 1000));
				
				/* timer only applies while the mouse is a certain distance from the menu */
				menupos = {
					right : menupos.left + megamenu.width() + buffer,
					bottom : menupos.top + megamenu.height() + buffer,
					top : menupos.top,
					left : menupos.left - buffer
				};
				$j(document).on("mousemove.menu",function(e){
					if (e.pageX < menupos.left || e.pageX > menupos.right || e.pageY < menupos.top || e.pageY > menupos.bottom){
						clearTimeout(self.data("timer"));
						$j(document).off("mousemove.menu");
						$j("li.open").removeClass("open");
					}
				});
			});

			/* allow a clicked dropdown link in the secondary nav to stay open */
			$j(".farcry-secondary-nav").on("click", ".nav:first > li.open > a", function(evt){
				return false;
			});

			/* live pretty dates */
			if (typeof moment != "undefined") {
				moment.lang(['#session.dmProfile.locale#', 'en']);
				moment.langData("en")._relativeTime.s = "moments";
				moment.langData("en_AU")._relativeTime.s = "moments";
				moment.langData("en_US")._relativeTime.s = "moments";
				function livePrettyDate(){
					$j(".fc-prettydate").each(function(){
						var el = $j(this);
						var d = el.data("datetime");
						if (d) {
							el.html(moment(d + " #numberFormat((getTimeZoneInfo().utcHourOffset*-1*100)+(getTimeZoneInfo().utcMinuteOffset*-1), "+0000")#", "YYYY-MM-DD HH:mm Z").fromNow());
						}
					})
				};
				livePrettyDate();
				setInterval(livePrettyDate, 30000);
			}

			/* remove updateapp from URL */
			var newURL = window.location.href.replace(/(updateapp=.*?([&]+|$))/gi, "").replace(/&$/gi, "");
			if (window.history.replaceState && newURL != window.location.href) {
				window.history.replaceState("", window.document.title, newURL);
			}

			/* navigation tabs overflow */
			var headerContainer = $j(".farcry-header-top");
			var brandContainer = $j(".farcry-header-brand");
			var utilityContainer = $j(".farcry-header-utility");
			var tabContainer = $j(".farcry-header-tabs ul");
			var tabItems = tabContainer.find("> li");
			var tabOverflowTimer = null;

			function renderTabOverflow() {

				var tabContainerWidth = headerContainer.width() - brandContainer.width() - utilityContainer.width() - 52;
				var tabTotalWidth = 0;
				var aHiddenTabs = [];
				var previousTab = null;
				var previousWidth = 0;
				var overflowActive = false;

				// set width again
				tabContainer.width(tabContainerWidth);

				// calculate widths and position of overflow dropdown
				tabItems.each(function(){
					var currentTab = this;
					var $el = $j(this);

					tabTotalWidth += $el.width();
					if ($el.hasClass("last")) {
						tabTotalWidth -= 50;
					}

					if (tabTotalWidth > (tabContainerWidth-previousWidth+50)) {
						if ($el.hasClass("nav-more")) {
							aHiddenTabs.push(previousTab);
							$el.remove();
						}
						else {
							aHiddenTabs.push(currentTab);
							$el.css("display", "none");
							if ($el.hasClass("active")) {
								overflowActive = true;
							}
						} 
					}
					else {
						if ($el.hasClass("nav-more")) {
							aHiddenTabs.push(previousTab);
							$el.remove();
						}
						else {
							$el.css("display", "block");
						}
					}

					previousTab = currentTab;
					previousWidth = $el.width();

				});

				// render overflow dropdown
				if (aHiddenTabs.length) {
					var dropdownHTML = "";
					tabContainer.find(".nav-more").remove();
					for (var i=0; i<aHiddenTabs.length;i++) {
						var $el = $j(aHiddenTabs[i]);
						dropdownHTML += "<li id='"+$el.attr("id")+"' class='"+$el.attr("class")+"'>" + $el.html() + "</li>";
					}
					$j("<li class='dropdown dropdown-toggle nav-more "+ ((overflowActive)?"active":"") +"'><a href='##'><i class='fa fa-caret-down'></i></a><ul class='dropdown-menu pull-right'>" + dropdownHTML + "</ul></li>").insertBefore(aHiddenTabs[0]);
				}
				else {
					tabContainer.find(".nav-more").remove();
				}

				$j(".farcry-header-tabs").css("overflow", "visible");
				$j(".farcry-header-tabs ul").css("overflow", "visible");

			}
			$j(window).resize(function(){
				clearTimeout(tabOverflowTimer);
				$j(".farcry-header-tabs").css("overflow", "hidden");
				$j(".farcry-header-tabs ul").css("overflow", "hidden");
				tabOverflowTimer = setTimeout(function(){
					renderTabOverflow();
				}, 150);
			});
			setTimeout(function(){
				renderTabOverflow();
			}, 300);


			
			<skin:pop>$j("##bubbles").append("<div class='alert<cfif listfindnocase(message.tags,'info')> alert-info<cfelseif listfindnocase(message.tags,'error')> alert-error<cfelseif listfindnocase(message.tags,'success')> alert-success</cfif>'><button type='button' class='close' data-dismiss='alert'>&times;</button><cfif len(trim(message.title))><strong>#application.fc.lib.esapi.encodeForJavascript(message.title)#</strong></cfif> <cfif len(trim(message.message))>#application.fc.lib.esapi.encodeForJavascript(message.message)#</cfif></div>");</skin:pop>
		});
		</script>

</body>
</html>
</cfoutput>

<cfsetting enablecfoutputonly="false">