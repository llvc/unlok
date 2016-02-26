require 'openssl'

# Configurable parameters... change below as per your subscription to Citrus
	
	$gateway 	= 'sandbox'     # options - sandbox, staging or production
	$pmturl 	= 'ucodrysn4r'	# as per citrus pay merchant setup
  $accesskey	= '7JGBQDUWUUZB1TNSMZVG' # as per citrus pay merchant setup
 	$apikey		= '4f00eca4ebc6b3d9cbaeaf72a7bb1230d0d65c04' # as per citrus pay merchant setup
 	
 	$action 	= 'http://localhost:3000/test/index' # change it as required by your app... 
 													 # the new action url will be generated below
  $returnUrl 	= 'http://localhost:3000/test/callback' # change is as required by your app
 	
 # end of configurable parameters


class TestController < ApplicationController
	skip_before_filter :authenticate

	def index
 		@flag=false
		@secSignature=''
		@reqtime = Time.now.to_f*1000
        	 
		ct = CitrusLib.new
		ct.setApiKey($apikey,$gateway)
	
		if params[:submit]=='Verify Transaction'
			data=$pmturl+params[:orderAmount]+params[:merchantTxnId]+params[:currency]
			@secSignature = ct.getHmac(data)
			$action=ct.getCpUrl+$pmturl 
			@flag=true
		end
	
	end
  
	def callback 	# to be called by Citrus to post response
		@data=''
		@action=''
		@status=false
		@statusmsg="Forged access"
	
		if params[:action] == 'callback'
			# signature verification data started
			@txid=params[:TxId]
			@data += @txid
			@txstatus=params[:TxStatus]
			@data += @txstatus
			@amount=params[:amount]
			@data += @amount
			@pgtxnno=params[:pgTxnNo]
			@data += @pgtxnno
			@issuerrefno=params[:issuerRefNo]
			@data += @issuerrefno
			@authidcode=params[:authIdCode]
			@data += @authidcode
			@firstname=params[:firstName]
			@data += @firstname
			@lastname=params[:lastName]
			@data += @lastname
			@pgrespcode=params[:pgRespCode]
			@data += @pgrespcode
			@addresszip=params[:addressZip]
			@data += @addresszip
			# signature verifcation data complete
		
			@signature=params[:signature]
			@txrefNo=params[:TxRefNo]
			@txmsg=params[:TxMsg]
			@transactionid=params[:transactionId]
			@paymentmode=params[:paymentMode]
			@txgateway=params[:TxGateway]
			@currency=params[:currency]
			@email=params[:email]
			@addressstreet1=params[:addressStreet1]
			@addressstreet2=params[:addressStreet2]
			@addresscity=params[:addressCity]
			@addressstate=params[:addressState]
			@addresscountry=params[:addressCountry]
			@mobileno=params[:mobileNo]
			@iscod=params[:isCOD]
			@controller=params[:controller]
			@action=params[:action]
			@status=true
		end
  	
  	
  	if @status==true
  		if @txstatus == 'CANCELED'
  			@statusmsg=@txmsg
  		elsif @txstatus == 'SUCCESS'
  			ct = CitrusLib.new
  			ct.setApiKey($apikey,$gateway)
  			secSignature = ct.getHmac(@data)
    			if secSignature != @signature    # post signature verification to prevent forgery
    				@status = false
    			else	
    				@statusmsg = 'Verified Response'
    			end
  			end
  		end
 	  end 
end

=begin
Citrus payment library class. During impletation to other applications the class to be copied
and incorporated to the application and calls to be made.

@ct = CitrusLib.new
@ct.setApiKey(<your api key>)
@sig=@ct.getHmac(<data>) - to generate hash to be posted to Citrus
@action = @ct.getCpUrl+@pmturl - get the first part of action url then append your payment url with it
=end

class CitrusLib

	def setApiKey (key,env)
		@@apiKey = key
		@@env = env
		
		case @@env
		when 'sandbox'
			@@apiUrl = @@SANDBOX_API_URL
			@@cpUrl = @@SANDBOX_PMT_URL
		when 'staging'
			@@apiUrl = @@STAGING_API_URL
			@@cpUrl = @@STAGING_PMT_URL
		when 'production'
			@@apiUrl = @@PRODUCTION_API_URL
			@@cpUrl = @@PRODUCTION_PMT_URL
		end
		
	end 
	
	def getApiUrl()
		return @@apiUrl
	end
  
	def getCpUrl()
		return @@cpUrl
	end
	
	def getHmac(data)
		digest = OpenSSL::Digest::Digest.new('sha1')
		sig=OpenSSL::HMAC.hexdigest(digest, @@apiKey, data)
		return sig
	end
	
	@@SANDBOX_API_URL='https://sandboxadmin.citruspay.com/api/v1/txn/'
	@@SANDBOX_PMT_URL='https://sandbox.citruspay.com/'
	
	@@STAGING_API_URL='https://stgadmin.citruspay.com/api/v1/txn/'
	@@STAGING_PMT_URL='https://stg.citruspay.com/'
	
	@@PRODUCTION_API_URL='https://admin.citruspay.com/api/v1/txn/'
	@@PRODUCTION_PMT_URL='https://www.citruspay.com/'
	
	@@apiKey=''
	@@env=''
	@@apiUrl=''
	@@cpUrl=''

end