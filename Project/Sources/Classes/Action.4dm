// Wrapper `On Mobile App Action` input
Class constructor
	C_OBJECT:C1216($1)
	This:C1470.name:=$1.action
	This:C1470.request:=$1
	
	If ($1=Null:C1517)
		
		ASSERT:C1129(False:C215; "Failed to "+Current method name:C684)
		
	End if 
	
Function getDataClass
	C_OBJECT:C1216($0)
	$0:=Mobile App Action GetDataClass(This:C1470.request)
	
Function getEntity
	C_OBJECT:C1216($0)
	$0:=Mobile App Action GetEntity(This:C1470.request)
	
Function getParent
	C_OBJECT:C1216($0)
	$0:=MA Action GetParentEntity(This:C1470.request)
	
Function newEntity
	C_OBJECT:C1216($0)
	$0:=Mobile App Action NewEntity(This:C1470.request)
	
Function dropEntity
	C_OBJECT:C1216($0)
	$0:=Mobile App Action DropEntity(This:C1470.request)
	
Function link
	C_OBJECT:C1216($0)
	$0:=Mobile App Action Link(This:C1470.request)
	
Function unlink
	C_OBJECT:C1216($0)
	$0:=Mobile App Action Unlink(This:C1470.request)
	
Function getApp
	C_OBJECT:C1216($0)
	$0:=MobileAppServer.App.new(New object:C1471("application"; This:C1470.request.application; "team"; This:C1470.request.team))
	
Function shareContext
	C_OBJECT:C1216($0; $response)
	$response:=New object:C1471("success"; False:C215)
	
	If (Value type:C1509(This:C1470.request.context)=Is object:K8:27)
		
		C_OBJECT:C1216($app; $context)
		$context:=This:C1470.request.context
		$app:=This:C1470.getApp()
		
		C_TEXT:C284($url)
		
		Case of 
			: (Bool:C1537($app.hasAssociatedDomains()))
				
				$response.success:=True:C214
				$url:=$app.universalLink($context)
				$response.share:=New collection:C1472(New object:C1471("value"; $url; "type"; "url"))
				
			: (Bool:C1537($app.hasURLScheme()))
				
				$response.success:=True:C214
				$url:=$app.urlSchemeURL($context)
				$response.share:=New collection:C1472(New object:C1471("value"; $url; "type"; "url"))
				
			Else 
				$response.statusText:="Sharing is not available yet"
				$response.errors:=New collection:C1472("No url scheme to defined url to share")
		End case 
		
	Else 
		// No context to share
	End if 
	
	$0:=$response
	