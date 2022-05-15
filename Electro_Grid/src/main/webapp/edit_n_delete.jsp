 <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<title>title</title>
	
    
    <script src="assets/js/croppie.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/jquery.validate.js"></script>
	
</head>
<body>
	
    <div class="container">
		
<br>
<p></p>
	                    <div>Payment List</div>
	                    <div>
	                        <div id="paymentDiv">
	                    	
	            			</div>
	                    </div>
	                    
	                   
<div id="hideDiv" style="display: none">
    <form id="paymentPortal">
    <input type="hidden" id="edit_id" name="edit_id">
           <div>
	                                <label>Bill id</label>
	                                <div>
	                                    <input type="text" id="bill_id" class="form-control" name="bill_id">
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>Card number</label>
	                                <div>
	                                    <input type="number" id="card_number" class="form-control" name="card_number">
	                                </div>
	                            </div>
   
	                         
	                            <div>
	                                <label>Card type</label>
	                                <div>
	                                    <select name="card_type" class="form-control" id="card_type">
	                                		<option value="VISA">VISA</option>
	                                		<option value="AMERICAN EXPRESS">AMERICAN EXPRESS</option>
	                                		<option value="MASTER">MASTER</option>
	                                	</select>
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>Amount</label>
	                                <div>
	                                    <input type="number" id="amount" class="form-control" name="amount">
	                                </div>
	                            </div>
          
          <div>
              <button type="submit" class="btn btn-success">
                  Edit
              </button>
          </div>
  	</form>
</div> 
	                    
</div>
	
</body>
</html>

<script>

    function deletes(id) {
    	if (confirm("Delete ?") == true) {
        	$.ajax({
                type: "DELETE",
                url: "api/payment",
                data: JSON.stringify({ 'id' : id}),
                dataType: "json",
    			contentType : 'application/json',
                success: function(data){
                	if(data['success']=="success"){
                		alert("Delete Successfull!");
    					reload();
    				}else if(data['success']=="0"){
    					alert("Delete Unsuccessful!");
    				}
                },
                failure: function(errMsg) {
                    alert('Error');
                }
            });
    	}
    }

    $(document).ready(function () {

    	 $("#paymentPortal").validate({
    	        rules: {
    	        	bill_id: "required",
    	            card_number: "required",
    	            card_type: "required",
    	            amount: "required",
    	        	
    	        },
    	        messages: {
    	        	bill_id: "bill id Required!",
    	            card_number: "card number Required!",
    	            card_type: "card type Required!",
    	            amount: "amount Required!",
    	           
    	        },
    	        submitHandler: function () {
    	        	var fromData = JSON.stringify({
    	        		"id":$('#edit_id').val(),
    	                "bill_id" : $('#bill_id').val(),
    	                "card_number" : $('#card_number').val(),
    	                "card_type" : $('#card_type').val(),
    	                "amount" : $('#amount').val(),
    	              
    	            });
    	        	
            	console.log(fromData);

                $.ajax({
                    type: "PUT",
                    url: 'api/payment',
                    dataType : 'json',
    				contentType : 'application/json',
    				data: fromData,
                    success: function(data){
                    	if(data['success']=="success"){
                    		alert("Edit Successfull!");
                        	document.getElementById("hideDiv").style.display = "none";
                            $("#paymentPortal")[0].reset();
    						reload();
    					}else{
    						alert("Unsuccessful!");
    					}
                    },
                    failure: function(errMsg) {
                    	alert("Connection Error!");
                    }
                });
            }
        });

        $("#paymentPortal").submit(function(e) {
            e.preventDefault();
        });

    });

    function reload(){
    	$.ajax({
            type: "GET",
            url: "api/payment",
            success: function(data){
            	$("#paymentDiv").html(data);
            },
            failure: function(errMsg) {
                alert('Error');
            }
        });
    }

    reload();
    
    function edit(id) {
    	document.getElementById("hideDiv").style.display = "block";
    	$.ajax({
            type: "POST",
            url: "api/payment/get",
            data: JSON.stringify({ 'id' : id}),
            dataType: "json",
			contentType : 'application/json',
            success: function(data){
            	console.log(data),
            	 $('#edit_id').val(data['id']),
            	 $('#bill_id').val(data['bill_id']),
	             $('#card_number').val(data['card_number']),
	             $('#card_type').val(data['card_type']),
	             $('#amount').val(data['amount'])
	              
            },
            failure: function(errMsg) {
                alert('Error');
            }
        });

        
    }
    
    
</script>