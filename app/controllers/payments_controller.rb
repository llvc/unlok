class PaymentsController < ApplicationController
  
  def hmac_sha1(data, secret)
    require 'base64'
    require 'cgi'
    require 'openssl'
    hmac = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha1'), secret.encode("ASCII"), data.encode("ASCII"))
    return hmac
  end
 
  def index
    # renders form
  end
 
  def submit
    require 'json'
    @secret_key = "91cd8d1ef5c3f5e43f096587fdbda41d48b552c4"
    @data = {}
    
    params[:form].each do |name,value|
      @data[name] = value
    end

    @verification_data = @data["TxId"]\
        + @data["TxStatus"] \
        + @data["amount"]\
        + @data["pgTxnNo"]\
        + @data["issuerRefNo"]\
        + @data["authIdCode"]\
        + @data["firstName"]\
        + @data["lastName"]\
        + @data["pgRespCode"]\
        + @data["addressZip"]
        
    @signature = hmac_sha1(@verification_data, @secret_key)
    #render :text=>@verification_data
    if @signature == @data["signature"]
      @json_object = @data.to_json
    # take some actions
      render :json => @json_object
    else
      @response_data = {"Error" => "Transaction Failed","Reason" => "Signature Verification Failed"}
      @json_object = @response_data.to_json
      # take some actions
      render :json => @json_object
    end
  end
 
 def bill_generate
   @access_key = "4IWZ7WV470OX37OEORZD"
   @secret_key = "91cd8d1ef5c3f5e43f096587fdbda41d48b552c4"
   @return_url = "#{request.base_url}/returnUrl"
   @txn_id = Time.now.to_f.to_s+rand(10000..99999).to_s
   @value = 1
   @data_string = "merchantAccessKey=#{@access_key}&transactionId=#{@txn_id}&amount=#{@value}" 
   @signature = hmac_sha1(@data_string,@secret_key) # signature generated
   @amount = {'value' => @value, 'currency' => 'INR'}
   @bill = {'merchantTxnId' => @txn_id,
            'amount' => @amount,
            'requestSignature' => @signature,
            'merchantAccessKey' => @access_key,
            'returnUrl' => @return_url}
   require 'json'
   render :json => @bill.to_json
 end 
end
