var dataResult = [];
var cnt = 0;
var checkedSim = [];
var simsJson = {};
function Sim(){
	
	var self = this;
	var global = new Global();
	this.params = {
		page: 0,
		filter: {}
	};
	this.perPage = 36;
	
	
	this.loadSims = function(page){
		self.params.page = page;
		sendPostAjax('/Sim/SearchSim', self.params, function(data){
			dataResult = data.sims;
			if(data.cnt == 0){
				$('#sim_list').html('<h2 style="color:red;font-family:rsu_bold;">ไม่พบข้อมูล</h2>');
				$('.paginations').html('');
			}else{
				self.renderSimsBlock(page);	
			}
		});
	}
	
	this.renderSimsBlock = function(page){
		var str  = '';
		var h = (page - 1) * self.perPage;
		var sims = dataResult.slice(h, h + self.perPage);
		var j = (dataResult.slice(h).length < self.perPage) ? dataResult.slice(h).length : self.perPage;
		
		for(var i = 0; i < sims.length; i++){
			//var k = i + h;
			var simNumber = sims[i].simNumber;
			if(checkedSim.indexOf(parseSimFormat(simNumber)) == -1){
				str += '<div data-ref="' + sims[i].simNumber + '" class="number">' + simNumber.slice(0, 3, '-') + '-' + simNumber.slice(3, 6, '-') + '-' + '<span class="txt-pink">' + simNumber.slice(6, 10, '-') + '</span></div>';
			}else{
				str += '<div data-ref="' + sims[i].simNumber + '" class="number active">' + simNumber.slice(0, 3, '-') + '-' + simNumber.slice(3, 6, '-') + '-' + '<span class="txt-pink">' + simNumber.slice(6, 10, '-') + '</span></div>';
			}
		}
		$('#sim_list').html(str);
		$('#selected_sim').html(checkedSim.length);
		var pagging = '';
		if(dataResult.length > self.perPage){
			var mod = Math.ceil(dataResult.length / self.perPage);
			var num = (page == 1) ? 1 : (page - 1);
			pagging += '<a class="page btn-first" onclick="getMobileList(1)"><i class="fa fa-angle-double-left"></i></a>';
			pagging += '<a class="page btn-back" onclick="getMobileList(' + num + ')"><i class="fa fa-angle-left"></i></a>';
			for(var i = 1; i <= mod; i++){
				if(page == i){
					pagging += '<a class="page btn-number active" onclick="getMobileList(' + i + ')">' + i + '</a>';
				}else{
					pagging += '<a class="page btn-number" onclick="getMobileList(' + i + ')">' + i + '</a>';
				}
			}
			num = (page == mod) ? page : ((page == 1) ? 2 : (page + 1));
			
			pagging += '<a class="page btn-next" onclick="getMobileList(' + num + ')"><i class="fa fa-angle-right"></i></a>';
			pagging += '<a class="page btn-last" onclick="getMobileList(' + mod + ')"><i class="fa fa-angle-double-right"></i></a>';
		}else if(dataResult.length != 0){
			pagging += '<a class="page btn-number active" onclick="getMobileList(1)">1</a>';
		}
		$('.paginations').html(pagging);
		$('#sim_list > .number').on('click',function(){
    		if($(this).hasClass('active')){
    			var tmp = [];
				var number = $(this).attr('data-ref');
				var j = 0;
				for(var i = 0; i < checkedSim.length; i++){
					if(number != checkedSim[i].replaceAll('-','')){
						tmp[j] = checkedSim[i];
						j++;
					}
				}
				checkedSim = tmp;
				$('#selected_sim').html(checkedSim.length);
				$(this).removeClass('active');
    		}else{
    			/*$('html, body').animate({
    				'scrollTop' : $(".btn-select-num").position().top
	    		});*/
	    		//Select item image and pass to the function
	    		var itemImg = $(this);
	    		self.flyToElement($(itemImg), $('.btn-select-num'));
    		}
    	});
	}
	
	this.flyToElement = function (flyer, flyingTo) {
    	var $func = $(this);
    	var divider = 3;
    	var flyerClone = $(flyer).clone();
    	$(flyer).addClass('active');
    	checkedSim[checkedSim.length] = $(flyer).text();
    	$(flyerClone).css({position: 'absolute', top: $(flyer).offset().top + "px", left: $(flyer).offset().left + "px", opacity: 1, 'z-index': 1000});
    	$('body').append($(flyerClone));
    	var gotoX = $(flyingTo).offset().left + ($(flyingTo).width() / 2) - ($(flyer).width()/divider)/2;
    	var gotoY = $(flyingTo).offset().top + ($(flyingTo).height() / 2) - ($(flyer).height()/divider)/2;
    	 
    	$(flyerClone).animate({
    		opacity: 0,
    		left: gotoX,
    		top: gotoY,
    		width: $(flyer).width()/divider,
    		height: $(flyer).height()/divider
    	}, 700,
    	function () {
    		$(flyingTo).fadeOut('fast', function () {
    			$(flyingTo).fadeIn('fast', function () {
    				$(flyerClone).fadeOut('fast', function () {
    					
    					var num = parseInt($('#selected_sim').html()) + 1;
    					$('#selected_sim').html(num);
    					//$(flyerClone).remove();
    				});
    			});
    		});
    	});
    }
}

function getMobileList(page){
	var sim = new Sim();
	sim.renderSimsBlock(page);
}

function jumpToSelectNumber(){
	if(checkedSim.length == 0){
		alertModal('Warning', 'ท่านยังไม่ได้เลือกเบอร์โทรศัพท์');
	}else{
		sendPostAjax('/Sim/SaveSesionSim', checkedSim, function(data){
			var global = new Global();
			window.location = global.contextPath() + 'SelectNumber';	
		});
	}
}
