<cfsetting enablecfoutputonly="true" />

<cfoutput>
<script>
// *********************************** Form Login Modal ***************************************** //

(function(){!function(a,b){return"function"==typeof define&&define.amd?define(function(){return b()}):"object"==typeof exports?module.exports=b():a.ifvisible=b()}(this,function(){var a,b,c,d,e,f,g,h,i,j,k,l,m,n;return i={},c=document,k=!1,l="active",g=6e4,f=!1,b=function(){var a,b,c,d,e,f,g;return a=function(){return(65536*(1+Math.random())|0).toString(16).substring(1)},e=function(){return a()+a()+"-"+a()+"-"+a()+"-"+a()+"-"+a()+a()+a()},f={},c="__ceGUID",b=function(a,b,d){return a[c]=void 0,a[c]||(a[c]="ifvisible.object.event.identifier"),f[a[c]]||(f[a[c]]={}),f[a[c]][b]||(f[a[c]][b]=[]),f[a[c]][b].push(d)},d=function(a,b,d){var e,g,h,i,j;if(a[c]&&f[a[c]]&&f[a[c]][b]){for(i=f[a[c]][b],j=[],g=0,h=i.length;h>g;g++)e=i[g],j.push(e(d||{}));return j}},g=function(a,b,d){var e,g,h,i,j;if(d){if(a[c]&&f[a[c]]&&f[a[c]][b])for(j=f[a[c]][b],g=h=0,i=j.length;i>h;g=++h)if(e=j[g],e===d)return f[a[c]][b].splice(g,1),e}else if(a[c]&&f[a[c]]&&f[a[c]][b])return delete f[a[c]][b]},{add:b,remove:g,fire:d}}(),a=function(){var a;return a=!1,function(b,c,d){return a||(a=b.addEventListener?function(a,b,c){return a.addEventListener(b,c,!1)}:b.attachEvent?function(a,b,c){return a.attachEvent("on"+b,c,!1)}:function(a,b,c){return a["on"+b]=c}),a(b,c,d)}}(),d=function(a,b){var d;return c.createEventObject?a.fireEvent("on"+b,d):(d=c.createEvent("HTMLEvents"),d.initEvent(b,!0,!0),!a.dispatchEvent(d))},h=function(){var a,b,d,e,f;for(e=void 0,f=3,d=c.createElement("div"),a=d.getElementsByTagName("i"),b=function(){return d.innerHTML="<!--[if gt IE "+ ++f+"]><i></i><![endif]-->",a[0]};b(););return f>4?f:e}(),e=!1,n=void 0,"undefined"!=typeof c.hidden?(e="hidden",n="visibilitychange"):"undefined"!=typeof c.mozHidden?(e="mozHidden",n="mozvisibilitychange"):"undefined"!=typeof c.msHidden?(e="msHidden",n="msvisibilitychange"):"undefined"!=typeof c.webkitHidden&&(e="webkitHidden",n="webkitvisibilitychange"),m=function(){var b,d;return b=!1,d=function(){return clearTimeout(b),"active"!==l&&i.wakeup(),f=+new Date,b=setTimeout(function(){return"active"===l?i.idle():void 0},g)},d(),a(c,"mousemove",d),a(c,"keyup",d),a(c,"touchstart",d),a(window,"scroll",d),i.focus(d),i.wakeup(d)},j=function(){var b;return k?!0:(e===!1?(b="blur",9>h&&(b="focusout"),a(window,b,function(){return i.blur()}),a(window,"focus",function(){return i.focus()})):a(c,n,function(){return c[e]?i.blur():i.focus()},!1),k=!0,m())},i={setIdleDuration:function(a){return g=1e3*a},getIdleDuration:function(){return g},getIdleInfo:function(){var a,b;return a=+new Date,b={},"idle"===l?(b.isIdle=!0,b.idleFor=a-f,b.timeLeft=0,b.timeLeftPer=100):(b.isIdle=!1,b.idleFor=a-f,b.timeLeft=f+g-a,b.timeLeftPer=(100-100*b.timeLeft/g).toFixed(2)),b},focus:function(a){return"function"==typeof a?this.on("focus",a):(l="active",b.fire(this,"focus"),b.fire(this,"wakeup"),b.fire(this,"statusChanged",{status:l})),this},blur:function(a){return"function"==typeof a?this.on("blur",a):(l="hidden",b.fire(this,"blur"),b.fire(this,"idle"),b.fire(this,"statusChanged",{status:l})),this},idle:function(a){return"function"==typeof a?this.on("idle",a):(l="idle",b.fire(this,"idle"),b.fire(this,"statusChanged",{status:l})),this},wakeup:function(a){return"function"==typeof a?this.on("wakeup",a):(l="active",b.fire(this,"wakeup"),b.fire(this,"statusChanged",{status:l})),this},on:function(a,c){return j(),b.add(this,a,c),this},off:function(a,c){return j(),b.remove(this,a,c),this},onEvery:function(a,b){var c,d;return j(),c=!1,b&&(d=setInterval(function(){return"active"===l&&c===!1?b():void 0},1e3*a)),{stop:function(){return clearInterval(d)},pause:function(){return c=!0},resume:function(){return c=!1},code:d,callback:b}},now:function(a){return j(),l===(a||"active")}}})}).call(this);

		$j(function(){
			
			var interval = 60000 * .1; // .1 of minute (ie 6sec)			
			var ajax_call = function() { // this will test if currently logged in or not
 			 //console.log('call done');
			 $j.ajax({
			url			: "#application.fapi.getLink(type=typename,objectid=objectid,view='displayIsLoggedIn',urlParameters='ajaxmode=1')#",
			
			type		: "POST",
			success		: function(data){
							//console.log('result:'+data);
							if (data) {
								//console.log('logged in - do not show login modal');
							} else {
								//console.log('Not logged in - show login modal');
								showLoginModal();
								//addEvent(document.getElementById('fcModal').contentWindow.document,"mousemove",wakeUp);							
							};
						  },
			dataType	: "json",
			cache:false
		});
			 
			};
			
		//var intervalID = setInterval(ajax_call, interval);// this starts the testing every so many seconds bassed on interval
		var showLoginModal = function(){ 
		openBootstrapLoginModal({ 
				title : "Are you still there? Your session has timed out.",
				url : "#application.url.webtop#/index.cfm?type=farQueueTask&view=displayLoginModal",
				onHidden: function() {
					//intervalID = setInterval(ajax_call, interval);
					return true;},
				onShown: function() {
					//clearInterval(intervalID);					
					return true;}
			});
			
		};
		
		var getTopBody = function() {
		var $topBody;
		var $currentDocument = $("document");
    while ($currentDocument.parent()){
         if ($currentDocument.find("body")){
              $topBody = $currentDocument.find("body");
              break;
         }
         $currentDocument = $currentDocument.parent();
    }
	return $topBody;
		}// end getTopBody
		
		
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
			

			
		ifvisible.on("wakeup", function(){
    // go back updating data
	console.log('wake up');
   ajax_call();
});
		ifvisible.onEvery(6, function(){
			
    // Do an animation on the logo only when page is visible
    console.log('visible');
	
	ajax_call();

});

		
		}); // end on jquery load
// *********************************** Form Login Modal END ***************************************** //	
</script>
</cfoutput>


<cfsetting enablecfoutputonly="false" />