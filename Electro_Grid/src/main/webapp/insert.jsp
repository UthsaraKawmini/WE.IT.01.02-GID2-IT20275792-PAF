<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<title>Title</title>
	
    <script src="assets/js/croppie.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/jquery.validate.js"></script>
	
</head>
<body>
	
    <div class="container">
		
<br>
<p></p>

	                    <div>Payment portal</div>
	                        <form id="paymentPortal">
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
	                                    Add
	                                </button>
	                                <a href="edit_n_delete.jsp" class="btn btn-success">
	                                    List
	                                </a>
	                            </div>
	                    	</form>
	                    </div>

</body>
</html>
<script>

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
                "bill_id" : $('#bill_id').val(),
                "card_number" : $('#card_number').val(),
                "card_type" : $('#card_type').val(),
                "amount" : $('#amount').val(),
              
            });
        	
        	console.log(fromData);

            $.ajax({
                type: "POST",
                url: 'api/payment',
                dataType : 'json',
				contentType : 'application/json',
				data: fromData,
                success: function(data){
                	console.log(data);
                	if(data['success']=="success"){
                		alert("Added Successfull!");
                        $("#paymentPortal")[0].reset();
					}else{
						alert("Unsuccessfull!");
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

</script>