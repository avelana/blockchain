 /* $(function() {
    var details = []; // array for full data about states

    // добавление нового продукта (данные константы, но можно легко брать их из формы)
	$("#add_product").click(function(){
		var branch = {
			phone: $("input#name").val(),// '111-111-1111',
			color: '222',
			price: 3.59
		}
	
		$.ajax({
			url: '/csp/dev/api/products',
			type: 'post',
			dataType: 'json',
			contentType: "application/json; charset=utf-8",
			success: function(data) {
				alert(data);
			}, // важный метод, чтобы передавался именно json
			data: JSON.stringify(product) 
		});
	});


	// обработчик клика на строке в списке продуктов, для получения деталей
	// используется .on вместо .click - из-за того что элементы class=".product" добавляютя динамически
    $( "#product_container" ).on( "click", ".product", function() {
    	alert($(this).data('item'));
    });
});
*/
$(document).ready(function(){
	var $select = $('#dates');
	$.ajax({url: "/blockchain/api/blocks",
	    	success: function(result){
		    	    	
		    	var data = JSON.parse(result);
		    	console.log(data[1].statename);
		    	
		    	$.each(data, function(i,item){
		    		//console.log(statename.ID+"  "+statename.name); 
	    			$select.append($('<option />', { value: item.id, text: item.statename }));
	    		});


	    	}
	});
	$.ajax({url: "/blockchain/api/peers",
	    	success: function(result){
		    	    	
		    	var data = JSON.parse(result);
		    	console.log(data);
		    	var $contaner = $('#water_quality_container'); 
		    	$.each(data, function(i,item){
		    		$contaner.append($('<option />', { value: item.id, text: item.statename }));
	    		});


	    	}
	});
	$.on('change', function() {
                //alert( this.value );  or $(this).val()
                console.log(this.value)
                var xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function() {
                     if (this.readyState == 4 && this.status == 200) {
                         document.getElementById("water_quality_container").innerHTML =
                         this.responseText;
                     }
                };
                xhttp.open("GET", "/water/api/waterstate/"+this.value, true);
                xhttp.send();
                
});
}
);
