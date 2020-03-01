xcode:
	xcodegen && xed .

xcg:
	xcodegen

fmt:
	swift-format . -r -i
	
needle:
	needle generate Apps/Todo_App/NeedleGenerated.swift ./
