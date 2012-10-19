unit GrymCore_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// $Rev: 31855 $
// File generated on 22.03.2012 13:02:46 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Program Files\2gis\3.0\grym.exe (1)
// LIBID: {7AA02C95-0B4A-43AA-92D8-BA40511A7F3F}
// LCID: 0
// Helpfile: 
// HelpString: GrymCore 3.2 Type Library (API-1.3)
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
// Errors:
//   Hint: Member 'Set' of 'IDevRect' changed to 'Set_'
//   Hint: Member 'Set' of 'IDevPoint' changed to 'Set_'
//   Hint: Member 'Set' of 'IDevSize' changed to 'Set_'
//   Hint: Member 'Property' of 'IPropertySet' changed to 'Property_'
//   Hint: Member 'Set' of 'IMapPoint' changed to 'Set_'
//   Hint: Member 'Set' of 'IMapRect' changed to 'Set_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Member 'Label' of 'IPluginShapeCursor' changed to 'Label_'
//   Hint: Member 'Record' of 'IStdDirectoryCellInfo' changed to 'Record_'
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}
interface

uses Windows, ActiveX, Classes, Graphics, OleServer, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  GrymCoreMajorVersion = 3;
  GrymCoreMinorVersion = 2;

  LIBID_GrymCore: TGUID = '{7AA02C95-0B4A-43AA-92D8-BA40511A7F3F}';

  IID_IHitTestFill: TGUID = '{8CE46871-64F4-4B1D-B767-F635FC84EF92}';
  IID_IDevRect: TGUID = '{8479A4BF-8AE4-4668-BA49-C564BBB28EDD}';
  IID_IDevPoint: TGUID = '{B0E2A21F-815A-4E87-B720-2D11E53976FC}';
  IID_IDevSize: TGUID = '{A9FEDBE9-24F9-41E6-B2F4-32AAA76B8DD2}';
  IID_IRaster: TGUID = '{FA9E10DC-A09F-42CB-BEA9-D5B2CE5F1333}';
  IID_IRasterSet: TGUID = '{EB703179-7340-4A56-9F5A-EF38985B1DB5}';
  IID_IRasterSetEdit: TGUID = '{680B8C10-5FD7-4F80-B578-1342B1A3CF88}';
  IID_IRasterBag: TGUID = '{3DDD1409-0647-45B9-9043-CA497E42C486}';
  IID_IActiveElement: TGUID = '{AF0D060B-80FF-414F-874A-7E81F2454BE8}';
  IID_IPropertySet: TGUID = '{298AABF0-95F0-44D9-AA7C-1E5927AE5D49}';
  IID_IObjectCustomization: TGUID = '{4D28DFB3-92CD-4AAF-B963-D00D1C4E77E9}';
  IID_IMapPoint: TGUID = '{ED1C8860-8165-4DEA-B2F5-A22A1A047ECD}';
  IID_IMapRect: TGUID = '{043C6213-9958-4E96-A796-4A64959821C2}';
  IID_IControlSet: TGUID = '{482689B3-45DB-4E87-A786-3905E8A5E572}';
  IID_IMenu: TGUID = '{64AC9CC0-9883-42EF-BEFB-9EDCC3E1FCB0}';
  IID_ISubMenu: TGUID = '{8BCDC1F9-C9CE-4D5F-A83B-68BEB76B1400}';
  IID_IPopupMenu: TGUID = '{15761DFB-3384-4C24-A55F-1B92BDC92AE6}';
  IID_IContextBase: TGUID = '{1FDE9FD2-C472-43F7-BC2B-18AD321F2A46}';
  IID_ISymbol: TGUID = '{9C07FB84-A123-437D-9023-CB592E495550}';
  IID_IMapDevice: TGUID = '{D41FA637-C0E3-48D0-A3CC-96B68DB76502}';
  IID_ILineSymbol: TGUID = '{224A8CEC-2749-43D6-8ECF-E0ED321448AA}';
  IID_IFillSymbol: TGUID = '{516E9F8A-6E7F-48AD-B2DB-CBCD41656DFD}';
  IID_IMarkerSymbol: TGUID = '{CC04A70D-F01B-4539-9AF9-9DE049904286}';
  IID_ISimpleLineSymbol: TGUID = '{3377AF3F-5360-4A76-B9A3-75942CB0B24B}';
  IID_ISimpleFillSymbol: TGUID = '{2027BC52-F648-457F-8856-FB650295144E}';
  IID_IRasterMarkerSymbol: TGUID = '{90E29939-3E7B-435C-8E1E-E94C6F529347}';
  IID_ITextSymbol: TGUID = '{37D82F27-E9A0-4FFD-BA9B-C843BCD8E7F0}';
  IID_IDirectoryViewCellFactory: TGUID = '{43B4D19E-F522-4484-93F3-E913D19280B6}';
  IID_IDirectoryViewCell: TGUID = '{7F38FFDC-CAD4-4711-8485-A2C5941EBA82}';
  IID_IDirectoryViewCellController: TGUID = '{DB7DD085-68FE-4417-8790-60FB4E369041}';
  IID_IDirectoryView: TGUID = '{C76205E6-35FE-4DDC-83AB-833D4649348D}';
  IID_ICriteriaSet: TGUID = '{88C82CAB-AAD8-4FC3-B67C-801EEC7D6165}';
  IID_IDirectoryCriteriaHelper: TGUID = '{C36A012D-A413-406C-A739-AC3D64240628}';
  IID_IBaseViewThread: TGUID = '{506A3A5E-825D-4353-8E35-0DDD1C11DCD2}';
  IID_IBaseReference: TGUID = '{EE719DD4-5C27-4441-AE57-B3DE040312F2}';
  IID_ICommandLine: TGUID = '{00BA9579-B6C3-40E2-8150-EB6868191A12}';
  IID_IGrymObjectFactory: TGUID = '{9FEEC37F-5EB0-421B-B36A-8719A0F4C9CC}';
  IID_IPluginManager: TGUID = '{17B388A1-5485-4488-B06D-0823FB48EA66}';
  IID_IGrymPlugin: TGUID = '{1FA777FF-10EF-434B-A735-99C6BFEB06D1}';
  IID_IGrym: TGUID = '{060EA9BC-5E81-49F0-AD1E-4CE9CB5022BF}';
  IID_IBaseCollection: TGUID = '{110FDA1A-3EA5-44DE-8158-842D13F5F8B6}';
  IID_IBaseIterator: TGUID = '{E495BB2E-B491-4EE3-AF33-220478FA0B5B}';
  IID_IDatabase: TGUID = '{487C8C7E-6041-48A6-8121-D1D6B18B6D0F}';
  IID_ITable: TGUID = '{3E97D2FB-EEC4-44D9-AD29-28ED456A48AF}';
  IID_IDataRow: TGUID = '{40D7E429-A27C-4F7E-A748-369F7BC19259}';
  IID_IQuery: TGUID = '{8FFA4E93-F2D8-4FE2-AAD2-59D7851EE92E}';
  IID_IBaseViewFrame: TGUID = '{4C9EF3B1-E281-44B3-9454-868E37E92680}';
  IID_IMap: TGUID = '{4B99828C-3CB0-4BA4-8DCA-49929B497661}';
  IID_ILayerCollection: TGUID = '{0F3D6150-F7AF-4738-9841-72898462E96E}';
  IID_ILayer: TGUID = '{8F09FECA-F4EB-47EE-9EC1-23092F13025C}';
  IID_IGrymLayer: TGUID = '{43D3201E-CDCF-44DB-A599-18F0968858F0}';
  IID_IMapInfoLayer: TGUID = '{9557DC11-0B72-472D-9881-E8BE3B094BD8}';
  IID_IMapInfoLayerBlock: TGUID = '{1A3ED061-E7F0-48E4-93FE-199A7D867FB4}';
  IID_IMapInfoLayerFiller: TGUID = '{0256A9C3-D993-455A-BFE7-08C027007511}';
  IID_IFeature: TGUID = '{668433F9-1DA3-4C2B-8D76-C3EF6AD9CABC}';
  IID_IMapInfoController: TGUID = '{85572ACF-7A31-445A-8322-7448DA5DE7D5}';
  IID_ICalloutTab: TGUID = '{1A8D4B37-2EAC-46DD-8A94-92187746D4B7}';
  IID_IGraphicBase: TGUID = '{B97D5F78-CDE2-4165-BF8D-B87DB1B0FE8C}';
  IID_ICallout: TGUID = '{BD11517D-8D3B-4087-9FAE-554CDD3C24F6}';
  IID_IMapTools: TGUID = '{F3FA33A8-8FBD-4BB0-9721-789A09BE6897}';
  IID_IToolBase: TGUID = '{63E83B7E-B232-47EF-8535-F7C795933E1A}';
  IID_IMapInfoControllers: TGUID = '{CE996283-7EC6-470A-AD18-00783626402F}';
  IID_ISelection: TGUID = '{673C253A-EC58-4A59-8171-CCA6005D318A}';
  IID_IAcceleratorTable: TGUID = '{E0577C77-4D55-455D-8796-8664F400EA4E}';
  IID_IRibbonBar: TGUID = '{B8513460-6DFA-4842-967D-0CC745A625EF}';
  IID_IRibbonTab: TGUID = '{959D410B-CFFA-41F2-B354-E4AB948516F7}';
  IID_IRibbonGroup: TGUID = '{0BF550C7-CEAB-4AF2-B939-92B69C625413}';
  IID_ICustomPageCollection: TGUID = '{B92F4E88-BC43-49C7-BFAB-298EC73B62CF}';
  IID_ICustomPage: TGUID = '{D1A64629-C474-4FAD-9123-92C45B9252B5}';
  IID_IDirectoryCollection: TGUID = '{1E933F83-308A-4D07-A0F5-AA93329B432B}';
  IID_IDirectory: TGUID = '{37B1AA55-E9B9-4A86-9985-4E6CA398D7CE}';
  IID_IGrymControl: TGUID = '{E15096D9-1A01-4AA2-B7E6-365E301BD826}';
  IID_IGrymHTMLViewControl: TGUID = '{45D8DFD5-00EF-4EE0-AF1F-6B0F01A650E9}';
  IID_IShapeFill: TGUID = '{C41BA6BB-66E5-4B2C-8497-38A26F056D1A}';
  IID_IStableTable: TGUID = '{E128E783-9342-4F58-B272-55F650FCCA5C}';
  IID_IGrymObjectFactory2: TGUID = '{39099042-45D5-47AB-ADA5-6803865F5FBD}';
  IID_IGrymObjectFactoryDeprecated: TGUID = '{9530BC2D-E492-4CD4-BB88-08D48575F91D}';
  IID_IGrymPluginInfo: TGUID = '{ABFDF706-F8B1-4145-BC75-528F232321B3}';
  IID_IGrymPluginOptions: TGUID = '{A8098FA0-A4BD-433E-93A6-BD05A1C6F288}';
  DIID__IBaseCollectionEvents: TGUID = '{98E734EB-E693-402E-807B-FBDC6FE183BA}';
  CLASS_BaseCollection: TGUID = '{F18C3BE8-90AC-44D3-8CDD-11EA2AA5AA3D}';
  CLASS_Grym: TGUID = '{1FE40EA0-BCD0-4235-B5F1-72123E3BA724}';
  IID_IScalableSymbol: TGUID = '{263D2C76-5955-4220-A59C-A53D6886F35F}';
  IID_IGraphicCustom: TGUID = '{EF2633EE-C59F-40C1-B14A-E9C31202BDB4}';
  IID_ICalloutTab2: TGUID = '{66491A2F-4254-4034-9AB7-69E8FAE5B023}';
  IID_ICalloutTab3: TGUID = '{172A3F61-4BE1-4EBB-A84E-493D2E910013}';
  IID_IPluginShapeCursor: TGUID = '{F600D260-61C2-4459-9B53-26D3B693A30E}';
  IID_IPluginShapeLayer: TGUID = '{26ED95F2-16B1-4DB9-8A47-E15166728AC4}';
  IID_IPluginCustomDrawLayer: TGUID = '{6D66C802-6D2F-4249-B752-1BDB5D15D82C}';
  IID_IMapInfoControllers2: TGUID = '{FBE77A92-5309-49A7-B766-CF90D3D4A64F}';
  IID_IMapInfoDirOrgFilter: TGUID = '{AFD535FF-E560-4786-A9F0-C8492F08ED9F}';
  IID_IMapInfoActionsCustomizer: TGUID = '{41667FDC-A081-4B5D-A076-65AA280CAE77}';
  IID_IPopupMenuMapViewContext: TGUID = '{FA96FE13-33A3-4F02-97C2-FADB29172836}';
  IID_IGrymToolRadius: TGUID = '{CD682230-8E2D-43BA-90F9-A00260AF9E78}';
  IID_ITool: TGUID = '{8B25C9C9-5FD8-4C6D-B8A3-AF12FDD17C3A}';
  IID_IMapCoordinateTransformationGeo: TGUID = '{E83B7E24-40C7-4845-AF23-52CB4D423C49}';
  IID_IMapCoordinateTransformationUTM: TGUID = '{F004BAFA-50C8-46F4-A565-DD70DDD9A0FD}';
  IID_IMapGraphics: TGUID = '{16AA5C37-04B2-4E9E-BB28-916A66B91504}';
  IID_IMapInfoLayerFiller2: TGUID = '{F81CA815-BACE-42D8-A8EC-B07D89FB7EE6}';
  IID_IMapInfoLayerFiller3: TGUID = '{D1A260DE-D627-4AD9-95D9-E27F75E194F6}';
  IID_IMapInfoLayerBlockProp: TGUID = '{07B67917-D5C7-40AF-8417-25767A9E250A}';
  IID_IMap2: TGUID = '{E782F45E-98E2-47DB-8D61-3E9578E78AD4}';
  DIID__ICalloutEvents: TGUID = '{5F45AD9C-B2F8-4DC8-8F66-A064E900FFDB}';
  CLASS_Callout: TGUID = '{E962B211-3FAB-4E0E-A477-079B19D7B6BC}';
  DIID__ICalloutTabEvents: TGUID = '{5FB3D6E9-48DD-4A7B-B049-5E9C5FA51CF8}';
  CLASS_CalloutTab: TGUID = '{21D331F9-7CC2-4BF9-A105-13B724A7D6C1}';
  IID_ISpatialFilter: TGUID = '{31AEA029-7E7B-44B7-80DE-AFD0F1190D3B}';
  IID_IDirectoryViewCellControllerProp: TGUID = '{99A4FD24-CF2E-44CB-A3A8-E326D18C93DA}';
  IID_IDirectoryExpandableViewCellController: TGUID = '{7855C715-DCBB-4998-A575-C7F4307B79AF}';
  IID_IDirectoryClipboardViewCellController: TGUID = '{07413F58-659B-4233-A49D-ABA1EECEFBB8}';
  IID_IDirectorySearchCursor: TGUID = '{1D0C5342-9AE5-48FB-BB8A-E7530DF641F3}';
  IID_IDirectoryService: TGUID = '{52EC6A48-C44E-43C2-807F-9D3403DDAB0E}';
  IID_IDirectoryEx: TGUID = '{C1CB6B80-9AE1-425E-B211-B66FDF5D0B20}';
  IID_IDirectoryCustom: TGUID = '{9ABE39D8-9045-4091-A2F6-4F6EE763A92F}';
  IID_IDirectoryHTMLViewCell: TGUID = '{40FF86FB-777E-4ABF-A9B9-08249FDB0966}';
  IID_IDirectoryHTMLViewCellController: TGUID = '{3D918276-3714-49DE-A4C9-28FB726221D7}';
  IID_IDirectoryPrintableViewCellController: TGUID = '{635AEF1B-C068-4E06-8C5A-ADD3ABA4682A}';
  IID_IStdDirectoryCustomControllerContainer: TGUID = '{C6F3064C-39C8-4394-ADC9-A0920444624C}';
  IID_IStdDirectoryDataRowFilter: TGUID = '{36012FDB-8C0D-46B9-9BED-DED2A204B439}';
  IID_IStdDirectoryQuickFilter: TGUID = '{8180847E-7ED4-4109-8891-0728E540446B}';
  IID_IStdDirectoryQueryCustomize: TGUID = '{747C4429-69BC-4421-9841-4140CEFECE3D}';
  IID_IStdDirectoryCustomFilterController: TGUID = '{EDACEE87-7A5F-426B-8917-CBAA0C153236}';
  IID_IStdDirectoryCellInfo: TGUID = '{51BEC9FC-D3A4-404A-9085-E0DB30C2D046}';
  IID_IStdDirectoryCellCustomController: TGUID = '{166C0B21-2A8F-42C8-8555-2EC5AD66276A}';
  IID_IStdDirectoryCustomController: TGUID = '{C399EC71-9A5A-4AB2-8070-AD284C811901}';
  IID_IGrymControlAutoSuggestionComboBox: TGUID = '{C5914DAD-685F-47A3-A135-8F6B8B47819C}';
  IID_IAutoSuggestionComboBoxController: TGUID = '{FCFC5ECB-ED58-47AD-B4D9-1E0E3DC912BA}';
  IID_IAutoSuggestionComboBoxFiller: TGUID = '{A4B83821-0EDA-455E-AC38-48D89309A620}';
  IID_ILegend: TGUID = '{D29EEA28-E455-4057-AAEA-8BD472406A8C}';
  IID_ILegendItem: TGUID = '{AB995D08-B1A9-448A-8DFE-B581CF2B7835}';
  IID_IContextBase2: TGUID = '{24DA589D-B826-47DD-80F4-8040FDF4BF7A}';
  IID_IControlPlacement: TGUID = '{2017A77A-043B-48A0-B3EA-F0504EC6CB2B}';
  IID_IControlAppearance: TGUID = '{4F46696D-9CCF-4953-B936-31E5B8763044}';
  IID_IControlState: TGUID = '{37F40CEC-1672-4032-904E-E7DA15327620}';
  IID_ICommandState: TGUID = '{6C91FE90-B064-48B0-A4B2-4A2EBDC94DE7}';
  IID_ICommandAccelerator: TGUID = '{0C043BDE-73D5-4049-A1DF-6B26F01D1FD1}';
  IID_ICommandAction: TGUID = '{56C38587-A7D2-4508-A35C-DA0249EE6645}';
  IID_ICommandQuickAccessOptions: TGUID = '{572796F9-EFE2-4C91-A670-C4966E3DC9E2}';
  IID_ICommandPopup: TGUID = '{48BD529A-7AD1-4416-99A1-29EC9EE2558E}';
  IID_IChildControl: TGUID = '{5EE60AD6-BB89-4780-9848-ADE9B8CED065}';
  IID_IRibbonGroup2: TGUID = '{F041D1D2-D14E-46EB-95D6-80F4982D59A8}';
  IID_ISearchRibbonGroup: TGUID = '{677540CD-6416-40CF-94AE-826AECF2DEAB}';
  IID_IRibbonGroupControl: TGUID = '{1729520F-168D-4D6F-801E-BA2208105662}';
  IID_ISearchGroupControl: TGUID = '{2ACC3822-A8E5-4843-9DAC-A7DEEE43D64A}';
  IID_IBaseViewFrame2: TGUID = '{BB5B7064-A01A-4BFF-8B0C-0D91584DAD33}';
  IID_IContainerControl: TGUID = '{198AFA7C-A6CA-41C0-909A-C1F4E9D16E69}';
  IID_IGrymControlEditHintHolder: TGUID = '{233F678C-2188-42F3-9E19-6D166F70CE8C}';
  IID_IGrymControlEditTextHolder: TGUID = '{6960289E-78CF-4976-9E0D-6A654282DDAD}';
  IID_IGrymControlComboBox: TGUID = '{61D4F18D-90F5-4506-ADA6-DF4423F76B3C}';
  IID_IGrymControlEdit: TGUID = '{6F37C3D9-BFD1-4E0E-9DCA-1DDF0373C76B}';
  IID_IListBoxItemDrawInfo: TGUID = '{C4B32C93-CE9D-40C9-A2DF-E96571B16FCA}';
  IID_IEditAreaDrawInfo: TGUID = '{3A2A65AE-6292-4AA3-B320-8CC89B416734}';
  IID_IListBoxItemDrawer: TGUID = '{5F10FA9A-D29A-489B-B97E-A1E8166B386D}';
  IID_IEditAreaDrawer: TGUID = '{B8E0C3B2-C086-42A5-BCF2-092BE63CB775}';
  IID_ICustomDrawGrymControlComboBox: TGUID = '{FDCC30BA-7042-4994-92CB-22CF5B13B3A2}';
  IID_IStatusFeedback: TGUID = '{0BE8D8AA-8E67-4D54-BDE2-E81D2214A6B9}';
  DIID__IGrymControlEditEvents: TGUID = '{5CE773A6-9501-4ECB-B98E-66E9D70E0085}';
  DIID__IGrymControlComboBoxEvents: TGUID = '{B80D4D83-8141-43A6-9DEC-9D0AC0777583}';
  DIID__IGrymControlAutoSuggestionComboBoxEvents: TGUID = '{44B559CF-9019-42D9-BD8C-7F163CD0A4B5}';
  DIID__IBaseViewFrameEvents: TGUID = '{7C158590-5DAF-48D6-BC86-B267F5E8935B}';
  DIID__IGrymHTMLViewControlEvents: TGUID = '{667F2E2B-7DD9-4E89-9AB5-6B095C0EC170}';
  CLASS_BaseViewFrame: TGUID = '{C8D6FB92-5F37-4E8F-BDE2-52073CBAA2C8}';
  CLASS_GrymControlComboBox: TGUID = '{C6538677-85AB-412A-8C7D-13A727A267B8}';
  CLASS_GrymControlEdit: TGUID = '{3761DFD8-CCD8-4480-B612-C8DF3A2A8A88}';
  CLASS_GrymHTMLViewControl: TGUID = '{D259612B-E069-4211-A50A-0453D1056061}';
  CLASS_GrymControlAutoSuggestionComboBox: TGUID = '{B226D186-9ABB-46EF-9D3C-C5C26EDBA1F2}';
  IID_IGrymAuthData: TGUID = '{58601E2C-AC6F-4B56-8E04-DFAD70F4FD39}';
  IID_IGrymProxyOptions: TGUID = '{B8B128C8-8D17-41EF-9C2A-65C5A319E999}';
  IID_IGrymConnectionOptionsCallback: TGUID = '{59418AFA-A778-41E6-A264-BC7495378AC0}';
  IID_IGrymConnectionOptions: TGUID = '{F6427B21-5061-4030-8AF5-C1AF84204FD0}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum MouseButton
type
  MouseButton = TOleEnum;
const
  MouseButtonNone = $00000000;
  MouseButtonLeft = $00000001;
  MouseButtonRight = $00000002;
  MouseButtonMiddle = $00000003;

// Constants for enum HTMLModificationType
type
  HTMLModificationType = TOleEnum;
const
  HTMLModificationTypeReplaceContent = $00000000;
  HTMLModificationTypeInsertBeforeFirstChild = $00000001;
  HTMLModificationTypeInsertAfterLastChild = $00000002;
  HTMLModificationTypeReplaceElement = $00000003;
  HTMLModificationTypeInsertBeforeElement = $00000004;
  HTMLModificationTypeInsertAfterElement = $00000005;

// Constants for enum DeviceType
type
  DeviceType = TOleEnum;
const
  DeviceTypeWindow = $00000000;
  DeviceTypeOverview = $00000001;
  DeviceTypePrinter = $00000002;

// Constants for enum SimpleLineStyle
type
  SimpleLineStyle = TOleEnum;
const
  SimpleLineStyleNull = $00000000;
  SimpleLineStyleSolid = $00000001;
  SimpleLineStyleDot = $00000002;
  SimpleLineStyleDash = $00000003;
  SimpleLineStyleDashDot = $00000004;
  SimpleLineStyleDashDotDot = $00000005;

// Constants for enum SimpleFillStyle
type
  SimpleFillStyle = TOleEnum;
const
  SimpleFillStyleNull = $00000000;
  SimpleFillStyleSolid = $00000001;
  SimpleFillStyleHatchedCross = $00000003;
  SimpleFillStyleHatchedDiagCross = $00000004;
  SimpleFillStyleHatchedHorizontal = $00000005;
  SimpleFillStyleHatchedVertical = $00000006;
  SimpleFillStyleHatchedBDiagonal = $00000007;
  SimpleFillStyleHatchedFDiagonal = $00000008;

// Constants for enum SymbolType
type
  SymbolType = TOleEnum;
const
  SymbolTypeRasterMarker = $00000000;
  SymbolTypeSimpleLine = $00000001;
  SymbolTypeSimpleFill = $00000002;
  SymbolTypeSimpleText = $00000003;

// Constants for enum CalloutStandardButtonType
type
  CalloutStandardButtonType = TOleEnum;
const
  CalloutStandardButtonTypeClose = $00000001;
  CalloutStandardButtonTypeLock = $00000002;

// Constants for enum RibbonGroupType
type
  RibbonGroupType = TOleEnum;
const
  RibbonGroupTypeSimple = $00000001;
  RibbonGroupTypeEx = $00000002;
  RibbonGroupTypeSearch = $00000003;

// Constants for enum BaseFrameViewMode
type
  BaseFrameViewMode = TOleEnum;
const
  BaseFrameViewModeStandard = $00000001;
  BaseFrameViewModePrintPreview = $00000002;

// Constants for enum GrymControlType
type
  GrymControlType = TOleEnum;
const
  GrymControlTypeLabel = $00000000;
  GrymControlTypeEdit = $00000001;
  GrymControlTypeCheckBox = $00000002;
  GrymControlTypeRadioButton = $00000003;
  GrymControlTypeComboBox = $00000004;
  GrymControlTypeCustomDrawComboBox = $00000005;
  GrymControlTypeAutoSuggestionComboBox = $00000006;

// Constants for enum GrymControlStyle
type
  GrymControlStyle = TOleEnum;
const
  GrymControlStyleAutomatic = $00000000;
  GrymControlStyleCaption = $00000001;
  GrymControlStyleIcon = $00000002;
  GrymControlStyleIconAndCaption = $00000003;
  GrymControlStyleIconAndCaptionBelow = $00000004;

// Constants for enum ComponentDimension
type
  ComponentDimension = TOleEnum;
const
  ComponentDimensionPoint = $00000000;
  ComponentDimensionLine = $00000001;
  ComponentDimensionPolygon = $00000002;
  ComponentDimensionText = $00000003;

// Constants for enum DirectoryViewCellControllerFlag
type
  DirectoryViewCellControllerFlag = TOleEnum;
const
  DirectoryViewCellControllerFlagNonCountable = $00000001;

// Constants for enum CellAdditionalContentType
type
  CellAdditionalContentType = TOleEnum;
const
  CellAdditionalContentTypeViewHTML = $00000001;
  CellAdditionalContentTypePrintHTML = $00000002;
  CellAdditionalContentTypeClipboardHTML = $00000003;
  CellAdditionalContentTypeClipboardRawText = $00000004;
  CellAdditionalContentTypePinInfoCardHTML = $00000005;

// Constants for enum ComboBoxStyle
type
  ComboBoxStyle = TOleEnum;
const
  ComboBoxStyleDropDown = $00000000;
  ComboBoxStyleDropDownList = $00000001;

// Constants for enum CustomDrawItemAction
type
  CustomDrawItemAction = TOleEnum;
const
  CustomDrawItemActionDrawEntire = $00000001;
  CustomDrawItemActionSelect = $00000002;
  CustomDrawItemActionFocus = $00000004;

// Constants for enum CustomDrawItemState
type
  CustomDrawItemState = TOleEnum;
const
  CustomDrawItemStateDisabled = $00000001;
  CustomDrawItemStateSelected = $00000002;
  CustomDrawItemStateFocused = $00000004;

// Constants for enum ProxyAuthType
type
  ProxyAuthType = TOleEnum;
const
  ProxyAuthTypeNone = $00000000;
  ProxyAuthTypeNTLM = $00000001;
  ProxyAuthTypeCustom = $00000002;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IHitTestFill = interface;
  IDevRect = interface;
  IDevPoint = interface;
  IDevSize = interface;
  IRaster = interface;
  IRasterSet = interface;
  IRasterSetEdit = interface;
  IRasterBag = interface;
  IActiveElement = interface;
  IPropertySet = interface;
  IObjectCustomization = interface;
  IMapPoint = interface;
  IMapRect = interface;
  IControlSet = interface;
  IMenu = interface;
  ISubMenu = interface;
  IPopupMenu = interface;
  IContextBase = interface;
  ISymbol = interface;
  IMapDevice = interface;
  ILineSymbol = interface;
  IFillSymbol = interface;
  IMarkerSymbol = interface;
  ISimpleLineSymbol = interface;
  ISimpleFillSymbol = interface;
  IRasterMarkerSymbol = interface;
  ITextSymbol = interface;
  IDirectoryViewCellFactory = interface;
  IDirectoryViewCell = interface;
  IDirectoryViewCellController = interface;
  IDirectoryView = interface;
  ICriteriaSet = interface;
  IDirectoryCriteriaHelper = interface;
  IBaseViewThread = interface;
  IBaseReference = interface;
  ICommandLine = interface;
  IGrymObjectFactory = interface;
  IPluginManager = interface;
  IGrymPlugin = interface;
  IGrym = interface;
  IBaseCollection = interface;
  IBaseIterator = interface;
  IDatabase = interface;
  ITable = interface;
  IDataRow = interface;
  IQuery = interface;
  IBaseViewFrame = interface;
  IMap = interface;
  ILayerCollection = interface;
  ILayer = interface;
  IGrymLayer = interface;
  IMapInfoLayer = interface;
  IMapInfoLayerBlock = interface;
  IMapInfoLayerFiller = interface;
  IFeature = interface;
  IMapInfoController = interface;
  ICalloutTab = interface;
  IGraphicBase = interface;
  ICallout = interface;
  IMapTools = interface;
  IToolBase = interface;
  IMapInfoControllers = interface;
  ISelection = interface;
  IAcceleratorTable = interface;
  IRibbonBar = interface;
  IRibbonTab = interface;
  IRibbonGroup = interface;
  ICustomPageCollection = interface;
  ICustomPage = interface;
  IDirectoryCollection = interface;
  IDirectory = interface;
  IGrymControl = interface;
  IGrymHTMLViewControl = interface;
  IShapeFill = interface;
  IStableTable = interface;
  IGrymObjectFactory2 = interface;
  IGrymObjectFactoryDeprecated = interface;
  IGrymPluginInfo = interface;
  IGrymPluginOptions = interface;
  _IBaseCollectionEvents = dispinterface;
  IScalableSymbol = interface;
  IGraphicCustom = interface;
  ICalloutTab2 = interface;
  ICalloutTab3 = interface;
  IPluginShapeCursor = interface;
  IPluginShapeLayer = interface;
  IPluginCustomDrawLayer = interface;
  IMapInfoControllers2 = interface;
  IMapInfoDirOrgFilter = interface;
  IMapInfoActionsCustomizer = interface;
  IPopupMenuMapViewContext = interface;
  IGrymToolRadius = interface;
  ITool = interface;
  IMapCoordinateTransformationGeo = interface;
  IMapCoordinateTransformationUTM = interface;
  IMapGraphics = interface;
  IMapInfoLayerFiller2 = interface;
  IMapInfoLayerFiller3 = interface;
  IMapInfoLayerBlockProp = interface;
  IMap2 = interface;
  _ICalloutEvents = dispinterface;
  _ICalloutTabEvents = dispinterface;
  ISpatialFilter = interface;
  IDirectoryViewCellControllerProp = interface;
  IDirectoryExpandableViewCellController = interface;
  IDirectoryClipboardViewCellController = interface;
  IDirectorySearchCursor = interface;
  IDirectoryService = interface;
  IDirectoryEx = interface;
  IDirectoryCustom = interface;
  IDirectoryHTMLViewCell = interface;
  IDirectoryHTMLViewCellController = interface;
  IDirectoryPrintableViewCellController = interface;
  IStdDirectoryCustomControllerContainer = interface;
  IStdDirectoryDataRowFilter = interface;
  IStdDirectoryQuickFilter = interface;
  IStdDirectoryQueryCustomize = interface;
  IStdDirectoryCustomFilterController = interface;
  IStdDirectoryCellInfo = interface;
  IStdDirectoryCellCustomController = interface;
  IStdDirectoryCustomController = interface;
  IGrymControlAutoSuggestionComboBox = interface;
  IAutoSuggestionComboBoxController = interface;
  IAutoSuggestionComboBoxFiller = interface;
  ILegend = interface;
  ILegendItem = interface;
  IContextBase2 = interface;
  IControlPlacement = interface;
  IControlAppearance = interface;
  IControlState = interface;
  ICommandState = interface;
  ICommandAccelerator = interface;
  ICommandAction = interface;
  ICommandQuickAccessOptions = interface;
  ICommandPopup = interface;
  IChildControl = interface;
  IRibbonGroup2 = interface;
  ISearchRibbonGroup = interface;
  IRibbonGroupControl = interface;
  ISearchGroupControl = interface;
  IBaseViewFrame2 = interface;
  IContainerControl = interface;
  IGrymControlEditHintHolder = interface;
  IGrymControlEditTextHolder = interface;
  IGrymControlComboBox = interface;
  IGrymControlEdit = interface;
  IListBoxItemDrawInfo = interface;
  IEditAreaDrawInfo = interface;
  IListBoxItemDrawer = interface;
  IEditAreaDrawer = interface;
  ICustomDrawGrymControlComboBox = interface;
  IStatusFeedback = interface;
  _IGrymControlEditEvents = dispinterface;
  _IGrymControlComboBoxEvents = dispinterface;
  _IGrymControlAutoSuggestionComboBoxEvents = dispinterface;
  _IBaseViewFrameEvents = dispinterface;
  _IGrymHTMLViewControlEvents = dispinterface;
  IGrymAuthData = interface;
  IGrymProxyOptions = interface;
  IGrymConnectionOptionsCallback = interface;
  IGrymConnectionOptions = interface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  BaseCollection = IBaseCollection;
  Grym = IGrym;
  Callout = ICallout;
  CalloutTab = ICalloutTab;
  BaseViewFrame = IBaseViewFrame;
  GrymControlComboBox = IGrymControlComboBox;
  GrymControlEdit = IGrymControlEdit;
  GrymHTMLViewControl = IGrymHTMLViewControl;
  GrymControlAutoSuggestionComboBox = IGrymControlAutoSuggestionComboBox;


// *********************************************************************//
// Interface: IHitTestFill
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {8CE46871-64F4-4B1D-B767-F635FC84EF92}
// *********************************************************************//
  IHitTestFill = interface(IUnknown)
    ['{8CE46871-64F4-4B1D-B767-F635FC84EF92}']
    function SetImage(const pIcon: IUnknown): HResult; stdcall;
    function SetCaption(const bsCaption: WideString): HResult; stdcall;
    function SetDescription(const bsDescription: WideString): HResult; stdcall;
    function SetRect(const pRect: IDevRect): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDevRect
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {8479A4BF-8AE4-4668-BA49-C564BBB28EDD}
// *********************************************************************//
  IDevRect = interface(IUnknown)
    ['{8479A4BF-8AE4-4668-BA49-C564BBB28EDD}']
    function Get_Min(out pVal: IDevPoint): HResult; stdcall;
    function Get_Max(out pVal: IDevPoint): HResult; stdcall;
    function Get_MinX(out pVal: Integer): HResult; stdcall;
    function Set_MinX(pVal: Integer): HResult; stdcall;
    function Get_MinY(out pVal: Integer): HResult; stdcall;
    function Set_MinY(pVal: Integer): HResult; stdcall;
    function Get_MaxX(out pVal: Integer): HResult; stdcall;
    function Set_MaxX(pVal: Integer): HResult; stdcall;
    function Get_MaxY(out pVal: Integer): HResult; stdcall;
    function Set_MaxY(pVal: Integer): HResult; stdcall;
    function Get_Width(out pVal: Integer): HResult; stdcall;
    function Get_Height(out pVal: Integer): HResult; stdcall;
    function Set_(nMinX: Integer; nMinY: Integer; nMaxX: Integer; nMaxY: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDevPoint
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {B0E2A21F-815A-4E87-B720-2D11E53976FC}
// *********************************************************************//
  IDevPoint = interface(IUnknown)
    ['{B0E2A21F-815A-4E87-B720-2D11E53976FC}']
    function Get_X(out pVal: Integer): HResult; stdcall;
    function Set_X(pVal: Integer): HResult; stdcall;
    function Get_Y(out pVal: Integer): HResult; stdcall;
    function Set_Y(pVal: Integer): HResult; stdcall;
    function Set_(nX: Integer; nY: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDevSize
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {A9FEDBE9-24F9-41E6-B2F4-32AAA76B8DD2}
// *********************************************************************//
  IDevSize = interface(IUnknown)
    ['{A9FEDBE9-24F9-41E6-B2F4-32AAA76B8DD2}']
    function Get_Width(out pVal: Integer): HResult; stdcall;
    function Set_Width(pVal: Integer): HResult; stdcall;
    function Get_Height(out pVal: Integer): HResult; stdcall;
    function Set_Height(pVal: Integer): HResult; stdcall;
    function Set_(nWidth: Integer; nHeight: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IRaster
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {FA9E10DC-A09F-42CB-BEA9-D5B2CE5F1333}
// *********************************************************************//
  IRaster = interface(IUnknown)
    ['{FA9E10DC-A09F-42CB-BEA9-D5B2CE5F1333}']
    function Get_Size(out pVal: IDevSize): HResult; stdcall;
    function Get_BitPerPixel(out pVal: Integer): HResult; stdcall;
    function Clone(out pVal: IRaster): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IRasterSet
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {EB703179-7340-4A56-9F5A-EF38985B1DB5}
// *********************************************************************//
  IRasterSet = interface(IUnknown)
    ['{EB703179-7340-4A56-9F5A-EF38985B1DB5}']
    function Get_Raster(const bsTag: WideString; out pVal: IRaster): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IRasterSetEdit
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {680B8C10-5FD7-4F80-B578-1342B1A3CF88}
// *********************************************************************//
  IRasterSetEdit = interface(IUnknown)
    ['{680B8C10-5FD7-4F80-B578-1342B1A3CF88}']
    function LockEditItf: HResult; stdcall;
    function Add(const bsTag: WideString; const pRaster: IRaster): HResult; stdcall;
    function Remove(const bsTag: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IRasterBag
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {3DDD1409-0647-45B9-9043-CA497E42C486}
// *********************************************************************//
  IRasterBag = interface(IUnknown)
    ['{3DDD1409-0647-45B9-9043-CA497E42C486}']
    function Get_Count(out pVal: Integer): HResult; stdcall;
    function Get_Item(nIndex: Integer; out pVal: IRaster): HResult; stdcall;
    function Add(const newVal: IRaster): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IActiveElement
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {AF0D060B-80FF-414F-874A-7E81F2454BE8}
// *********************************************************************//
  IActiveElement = interface(IUnknown)
    ['{AF0D060B-80FF-414F-874A-7E81F2454BE8}']
    function ProcessMessage(nMessage: Integer; wParam: Integer; lParam: Integer; 
                            out pProcessed: WordBool): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IPropertySet
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {298AABF0-95F0-44D9-AA7C-1E5927AE5D49}
// *********************************************************************//
  IPropertySet = interface(IUnknown)
    ['{298AABF0-95F0-44D9-AA7C-1E5927AE5D49}']
    function Get_Property_(const bsPropertyName: WideString; out pVal: OleVariant): HResult; stdcall;
    function Set_Property_(const bsPropertyName: WideString; pVal: OleVariant): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IObjectCustomization
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {4D28DFB3-92CD-4AAF-B963-D00D1C4E77E9}
// *********************************************************************//
  IObjectCustomization = interface(IUnknown)
    ['{4D28DFB3-92CD-4AAF-B963-D00D1C4E77E9}']
    function RegisterCustomizer(const pVal: IUnknown): HResult; stdcall;
    function UnregisterCustomizer(const pVal: IUnknown): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMapPoint
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {ED1C8860-8165-4DEA-B2F5-A22A1A047ECD}
// *********************************************************************//
  IMapPoint = interface(IUnknown)
    ['{ED1C8860-8165-4DEA-B2F5-A22A1A047ECD}']
    function Get_X(out pVal: Double): HResult; stdcall;
    function Set_X(pVal: Double): HResult; stdcall;
    function Get_Y(out pVal: Double): HResult; stdcall;
    function Set_Y(pVal: Double): HResult; stdcall;
    function Set_(nX: Double; nY: Double): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMapRect
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {043C6213-9958-4E96-A796-4A64959821C2}
// *********************************************************************//
  IMapRect = interface(IUnknown)
    ['{043C6213-9958-4E96-A796-4A64959821C2}']
    function Get_Min(out pVal: IMapPoint): HResult; stdcall;
    function Get_Max(out pVal: IMapPoint): HResult; stdcall;
    function Get_MinX(out pVal: Double): HResult; stdcall;
    function Set_MinX(pVal: Double): HResult; stdcall;
    function Get_MinY(out pVal: Double): HResult; stdcall;
    function Set_MinY(pVal: Double): HResult; stdcall;
    function Get_MaxX(out pVal: Double): HResult; stdcall;
    function Set_MaxX(pVal: Double): HResult; stdcall;
    function Get_MaxY(out pVal: Double): HResult; stdcall;
    function Set_MaxY(pVal: Double): HResult; stdcall;
    function Get_Width(out pVal: Double): HResult; stdcall;
    function Get_Height(out pVal: Double): HResult; stdcall;
    function Set_(nMinX: Double; nMinY: Double; nMaxX: Double; nMaxY: Double): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IControlSet
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {482689B3-45DB-4E87-A786-3905E8A5E572}
// *********************************************************************//
  IControlSet = interface(IUnknown)
    ['{482689B3-45DB-4E87-A786-3905E8A5E572}']
    function AddControl(const pCtl: IUnknown): HResult; stdcall;
    function RemoveControl(const pCtl: IUnknown): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMenu
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {64AC9CC0-9883-42EF-BEFB-9EDCC3E1FCB0}
// *********************************************************************//
  IMenu = interface(IControlSet)
    ['{64AC9CC0-9883-42EF-BEFB-9EDCC3E1FCB0}']
    function AddSubMenu(const bsPlacementCode: WideString; const bsCaption: WideString; 
                        out pVal: ISubMenu): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISubMenu
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {8BCDC1F9-C9CE-4D5F-A83B-68BEB76B1400}
// *********************************************************************//
  ISubMenu = interface(IMenu)
    ['{8BCDC1F9-C9CE-4D5F-A83B-68BEB76B1400}']
    function Get_PlacementCode(out pVal: WideString): HResult; stdcall;
    function Get_Caption(out pVal: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IPopupMenu
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {15761DFB-3384-4C24-A55F-1B92BDC92AE6}
// *********************************************************************//
  IPopupMenu = interface(IMenu)
    ['{15761DFB-3384-4C24-A55F-1B92BDC92AE6}']
    function Show(const pPos: IDevPoint; const pContext: IContextBase; const pExcludeRect: IDevRect): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IContextBase
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {1FDE9FD2-C472-43F7-BC2B-18AD321F2A46}
// *********************************************************************//
  IContextBase = interface(IUnknown)
    ['{1FDE9FD2-C472-43F7-BC2B-18AD321F2A46}']
    function Get_CustomInfo(const bsKey: WideString; out pVal: OleVariant): HResult; stdcall;
    function Set_CustomInfo(const bsKey: WideString; pVal: OleVariant): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISymbol
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {9C07FB84-A123-437D-9023-CB592E495550}
// *********************************************************************//
  ISymbol = interface(IUnknown)
    ['{9C07FB84-A123-437D-9023-CB592E495550}']
    function Draw(const pDevice: IMapDevice; vtPoints: OleVariant; vtParts: OleVariant; 
                  vtAdditionalData: OleVariant): HResult; stdcall;
    function DrawSample(hDC: OLE_HANDLE; const pDevRect: IDevRect): HResult; stdcall;
    function CloneHighlighted(clrHightlight: OLE_COLOR; out pClone: ISymbol): HResult; stdcall;
    function IsPointInside(const pDevice: IMapDevice; const pPos: IMapPoint; vtPoints: OleVariant; 
                           vtParts: OleVariant; vtAdditionalData: OleVariant; out pRet: WordBool): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMapDevice
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {D41FA637-C0E3-48D0-A3CC-96B68DB76502}
// *********************************************************************//
  IMapDevice = interface(IUnknown)
    ['{D41FA637-C0E3-48D0-A3CC-96B68DB76502}']
    function Get_type_(out pVal: DeviceType): HResult; stdcall;
    function Get_SafeDC(out pVal: OLE_HANDLE): HResult; stdcall;
    function Get_DeviceRect(out pVal: IDevRect): HResult; stdcall;
    function Get_Scale(out pVal: Integer): HResult; stdcall;
    function MapToDevice(const pPtMap: IMapPoint; out pPtDev: IDevPoint): HResult; stdcall;
    function DeviceToMap(const pPtDev: IDevPoint; out pPtMap: IMapPoint): HResult; stdcall;
    function MapToDeviceMeasure(nMapLength: Double; out pLenDev: Integer): HResult; stdcall;
    function DeviceToMapMeasure(nDevLength: Integer; out pLenMap: Double): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ILineSymbol
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {224A8CEC-2749-43D6-8ECF-E0ED321448AA}
// *********************************************************************//
  ILineSymbol = interface(ISymbol)
    ['{224A8CEC-2749-43D6-8ECF-E0ED321448AA}']
  end;

// *********************************************************************//
// Interface: IFillSymbol
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {516E9F8A-6E7F-48AD-B2DB-CBCD41656DFD}
// *********************************************************************//
  IFillSymbol = interface(ISymbol)
    ['{516E9F8A-6E7F-48AD-B2DB-CBCD41656DFD}']
    function Get_Outline(out ppSymbol: ILineSymbol): HResult; stdcall;
    function _Set_Outline(const ppSymbol: ILineSymbol): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMarkerSymbol
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {CC04A70D-F01B-4539-9AF9-9DE049904286}
// *********************************************************************//
  IMarkerSymbol = interface(ISymbol)
    ['{CC04A70D-F01B-4539-9AF9-9DE049904286}']
    function Get_Angle(out pVal: Integer): HResult; stdcall;
    function Set_Angle(pVal: Integer): HResult; stdcall;
    function GetMarkerSize(const pDevice: IMapDevice; out pVal: IDevSize): HResult; stdcall;
    function Get_HotSpotX(out pVal: Double): HResult; stdcall;
    function Get_HotSpotY(out pVal: Double): HResult; stdcall;
    function SetHotSpot(newX: Double; newY: Double): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISimpleLineSymbol
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {3377AF3F-5360-4A76-B9A3-75942CB0B24B}
// *********************************************************************//
  ISimpleLineSymbol = interface(ILineSymbol)
    ['{3377AF3F-5360-4A76-B9A3-75942CB0B24B}']
    function Get_Style(out pVal: SimpleLineStyle): HResult; stdcall;
    function Set_Style(pVal: SimpleLineStyle): HResult; stdcall;
    function Get_Color(out pVal: OLE_COLOR): HResult; stdcall;
    function Set_Color(pVal: OLE_COLOR): HResult; stdcall;
    function Get_Width(out pVal: Double): HResult; stdcall;
    function Set_Width(pVal: Double): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISimpleFillSymbol
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {2027BC52-F648-457F-8856-FB650295144E}
// *********************************************************************//
  ISimpleFillSymbol = interface(IFillSymbol)
    ['{2027BC52-F648-457F-8856-FB650295144E}']
    function Get_Style(out pVal: SimpleFillStyle): HResult; stdcall;
    function Set_Style(pVal: SimpleFillStyle): HResult; stdcall;
    function Get_ColorFg(out pVal: OLE_COLOR): HResult; stdcall;
    function Set_ColorFg(pVal: OLE_COLOR): HResult; stdcall;
    function Get_ColorBg(out pVal: OLE_COLOR): HResult; stdcall;
    function Set_ColorBg(pVal: OLE_COLOR): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IRasterMarkerSymbol
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {90E29939-3E7B-435C-8E1E-E94C6F529347}
// *********************************************************************//
  IRasterMarkerSymbol = interface(IMarkerSymbol)
    ['{90E29939-3E7B-435C-8E1E-E94C6F529347}']
    function SetRaster(const pRaster: IRaster; nScale: Double): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ITextSymbol
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {37D82F27-E9A0-4FFD-BA9B-C843BCD8E7F0}
// *********************************************************************//
  ITextSymbol = interface(ISymbol)
    ['{37D82F27-E9A0-4FFD-BA9B-C843BCD8E7F0}']
    function Get_Font(out pVal: IFont): HResult; stdcall;
    function _Set_Font(const pVal: IFont): HResult; stdcall;
    function Get_Color(out pVal: OLE_COLOR): HResult; stdcall;
    function Set_Color(pVal: OLE_COLOR): HResult; stdcall;
    function DrawTextSymbol(const pDevice: IMapDevice; nX: Integer; nY: Integer; 
                            const bsText: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDirectoryViewCellFactory
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {43B4D19E-F522-4484-93F3-E913D19280B6}
// *********************************************************************//
  IDirectoryViewCellFactory = interface(IUnknown)
    ['{43B4D19E-F522-4484-93F3-E913D19280B6}']
    function CreateViewCell(out pVal: IDirectoryViewCell): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDirectoryViewCell
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {7F38FFDC-CAD4-4711-8485-A2C5941EBA82}
// *********************************************************************//
  IDirectoryViewCell = interface(IUnknown)
    ['{7F38FFDC-CAD4-4711-8485-A2C5941EBA82}']
    function CalcHeight(hDC: OLE_HANDLE; nWidth: Integer; out pHeight: Integer): HResult; stdcall;
    function Draw(hDC: OLE_HANDLE; const pLocalDrawBounds: IDevRect): HResult; stdcall;
    function OnSetCursor(const pLocalCursorPosition: IDevPoint; out bDone: WordBool): HResult; stdcall;
    function OnClick(const pLocalClickPosition: IDevPoint): HResult; stdcall;
    function FillContextMenu(const pLocalPosition: IDevPoint; const pMenu: IMenu): HResult; stdcall;
    function Get_Controller(out pVal: IDirectoryViewCellController): HResult; stdcall;
    function _Set_Controller(const pVal: IDirectoryViewCellController): HResult; stdcall;
    function Get_View(out pVal: IDirectoryView): HResult; stdcall;
    function _Set_View(const pVal: IDirectoryView): HResult; stdcall;
    function HitTest(const pLocalCursorPosition: IDevPoint; const pFill: IHitTestFill; 
                     out bDone: WordBool): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDirectoryViewCellController
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {DB7DD085-68FE-4417-8790-60FB4E369041}
// *********************************************************************//
  IDirectoryViewCellController = interface(IUnknown)
    ['{DB7DD085-68FE-4417-8790-60FB4E369041}']
    function OnAttach(const pCell: IDirectoryViewCell): HResult; stdcall;
    function OnDetach: HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDirectoryView
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {C76205E6-35FE-4DDC-83AB-833D4649348D}
// *********************************************************************//
  IDirectoryView = interface(IUnknown)
    ['{C76205E6-35FE-4DDC-83AB-833D4649348D}']
    function OnCellChanged(const pVal: IDirectoryViewCell): HResult; stdcall;
    function EnsureVisible(const pVal: IDirectoryViewCell): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ICriteriaSet
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {88C82CAB-AAD8-4FC3-B67C-801EEC7D6165}
// *********************************************************************//
  ICriteriaSet = interface(IUnknown)
    ['{88C82CAB-AAD8-4FC3-B67C-801EEC7D6165}']
    function Get_Criterion(const bsName: WideString; out pVal: OleVariant): HResult; stdcall;
    function Set_Criterion(const bsName: WideString; pVal: OleVariant): HResult; stdcall;
    function Get_Empty(out pVal: WordBool): HResult; stdcall;
    function Get_Count(out pVal: Integer): HResult; stdcall;
    function Get_CriterionName(nIndex: Integer; out pVal: WideString): HResult; stdcall;
    function Get_CriterionValue(nIndex: Integer; out pVal: OleVariant): HResult; stdcall;
    function Get_Exists(const bsName: WideString; out pVal: WordBool): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDirectoryCriteriaHelper
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {C36A012D-A413-406C-A739-AC3D64240628}
// *********************************************************************//
  IDirectoryCriteriaHelper = interface(IUnknown)
    ['{C36A012D-A413-406C-A739-AC3D64240628}']
    function Get_Exists(const bsName: WideString; out pVal: WordBool): HResult; stdcall;
    function Get_Criterion(const bsName: WideString; out pVal: OleVariant): HResult; stdcall;
    function Get_UsedAll(out pVal: WordBool): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IBaseViewThread
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {506A3A5E-825D-4353-8E35-0DDD1C11DCD2}
// *********************************************************************//
  IBaseViewThread = interface(IUnknown)
    ['{506A3A5E-825D-4353-8E35-0DDD1C11DCD2}']
    function Get_BaseReference(out pVal: IBaseReference): HResult; stdcall;
    function Activate(nCmdShow: Integer): HResult; stdcall;
    function ExecuteCommandLine(const pCmdLine: ICommandLine; out pResult: OleVariant): HResult; stdcall;
    function Get_Factory(out pVal: IGrymObjectFactory): HResult; stdcall;
    function Get_PluginManager(out pVal: IPluginManager): HResult; stdcall;
    function Get_Database(out pVal: IDatabase): HResult; stdcall;
    function Get_Frame(out pVal: IBaseViewFrame): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IBaseReference
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {EE719DD4-5C27-4441-AE57-B3DE040312F2}
// *********************************************************************//
  IBaseReference = interface(IUnknown)
    ['{EE719DD4-5C27-4441-AE57-B3DE040312F2}']
    function Get_Name(out pVal: WideString): HResult; stdcall;
    function Get_IssueDate(out pVal: TDateTime): HResult; stdcall;
    function Get_FullName(out pVal: WideString): HResult; stdcall;
    function Get_FullPath(out pVal: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ICommandLine
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {00BA9579-B6C3-40E2-8150-EB6868191A12}
// *********************************************************************//
  ICommandLine = interface(IUnknown)
    ['{00BA9579-B6C3-40E2-8150-EB6868191A12}']
    function Get_ArgumentCount(out pVal: Integer): HResult; stdcall;
    function Get_ArgumentValue(nPos: Integer; out pVal: OleVariant): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IGrymObjectFactory
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {9FEEC37F-5EB0-421B-B36A-8719A0F4C9CC}
// *********************************************************************//
  IGrymObjectFactory = interface(IUnknown)
    ['{9FEEC37F-5EB0-421B-B36A-8719A0F4C9CC}']
    function CreateDevPoint(nX: Integer; nY: Integer; out pResult: IDevPoint): HResult; stdcall;
    function CreateDevRect(nMinX: Integer; nMinY: Integer; nMaxX: Integer; nMaxY: Integer; 
                           out pResult: IDevRect): HResult; stdcall;
    function CreateDevSize(nWidth: Integer; nHeight: Integer; out pResult: IDevSize): HResult; stdcall;
    function CreateMapPoint(nX: Double; nY: Double; out pResult: IMapPoint): HResult; stdcall;
    function CreateMapRect(nMinX: Double; nMinY: Double; nMaxX: Double; nMaxY: Double; 
                           out pResult: IMapRect): HResult; stdcall;
    function CreatePopupMenu(out pResult: IPopupMenu): HResult; stdcall;
    function ParseCommandLine(const bsCmdLine: WideString; out pVal: ICommandLine): HResult; stdcall;
    function CreateRasterFromFile(const bsFileName: WideString; out pResult: IRaster): HResult; stdcall;
    function CreateRasterFromMemory(saVal: PSafeArray; out pResult: IRaster): HResult; stdcall;
    function MakeHighlightedRaster(const pRaster: IRaster; clrHighlight: OLE_COLOR; 
                                   out pVal: IRaster): HResult; stdcall;
    function CreateRasterSet(out pVal: IRasterSetEdit): HResult; stdcall;
    function CreateRasterBag(out pVal: IRasterBag): HResult; stdcall;
    function CreateSymbol(nType: SymbolType; out pResult: ISymbol): HResult; stdcall;
    function CreateSimpleLineSymbol(nStyle: SimpleLineStyle; nWidth: Double; clrLine: OLE_COLOR; 
                                    out pResult: ISimpleLineSymbol): HResult; stdcall;
    function CreateSimpleFillSymbol(nStyle: SimpleFillStyle; clrForeground: OLE_COLOR; 
                                    clrBackground: OLE_COLOR; const pBorder: ILineSymbol; 
                                    out pResult: ISimpleFillSymbol): HResult; stdcall;
    function CreateRasterMarkerSymbol(const pRaster: IRaster; nScale: Double; 
                                      out pResult: IRasterMarkerSymbol): HResult; stdcall;
    function CreateTextSymbol(const pFont: IFont; clrText: OLE_COLOR; out pResult: ITextSymbol): HResult; stdcall;
    function Get_DirectoryHTMLViewCellFactory(out pVal: IDirectoryViewCellFactory): HResult; stdcall;
    function CreateCriteriaSet(const pToClone: ICriteriaSet; out pVal: ICriteriaSet): HResult; stdcall;
    function CreateDirectoryCriteriaHelper(const pCriteria: ICriteriaSet; 
                                           out pVal: IDirectoryCriteriaHelper): HResult; stdcall;
    function CreateRasterSampleOfSymbol(const pSize: IDevSize; const pSymbol: ISymbol; 
                                        out pVal: IRaster): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IPluginManager
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {17B388A1-5485-4488-B06D-0823FB48EA66}
// *********************************************************************//
  IPluginManager = interface(IUnknown)
    ['{17B388A1-5485-4488-B06D-0823FB48EA66}']
    function Get_Plugin(const bsTag: WideString; out pVal: IGrymPlugin): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IGrymPlugin
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {1FA777FF-10EF-434B-A735-99C6BFEB06D1}
// *********************************************************************//
  IGrymPlugin = interface(IUnknown)
    ['{1FA777FF-10EF-434B-A735-99C6BFEB06D1}']
    function Initialize(const pRoot: IGrym; const pBaseView: IBaseViewThread): HResult; stdcall;
    function Terminate: HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IGrym
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {060EA9BC-5E81-49F0-AD1E-4CE9CB5022BF}
// *********************************************************************//
  IGrym = interface(IUnknown)
    ['{060EA9BC-5E81-49F0-AD1E-4CE9CB5022BF}']
    function Get_IssueDate(out pVal: TDateTime): HResult; stdcall;
    function Get_MinBaseDate(out pVal: TDateTime): HResult; stdcall;
    function Get_BaseCollection(out pVal: IBaseCollection): HResult; stdcall;
    function GetBaseView(const pBaseRef: IBaseReference; bRun: WordBool; 
                         bAllowChangeFromUI: WordBool; out pVal: IBaseViewThread): HResult; stdcall;
    function Get_ProcessId(out pVal: Integer): HResult; stdcall;
    function Get_MarkerWindow(out pVal: OLE_HANDLE): HResult; stdcall;
    function ExecuteCommandLine(const pCmdLine: ICommandLine; out pResult: OleVariant): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IBaseCollection
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {110FDA1A-3EA5-44DE-8158-842D13F5F8B6}
// *********************************************************************//
  IBaseCollection = interface(IUnknown)
    ['{110FDA1A-3EA5-44DE-8158-842D13F5F8B6}']
    function GetBaseIterator(out pVal: IBaseIterator): HResult; stdcall;
    function FindBase(const key: WideString; out pVal: IBaseReference): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IBaseIterator
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {E495BB2E-B491-4EE3-AF33-220478FA0B5B}
// *********************************************************************//
  IBaseIterator = interface(IUnknown)
    ['{E495BB2E-B491-4EE3-AF33-220478FA0B5B}']
    function GetNext(out pVal: IBaseReference): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDatabase
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {487C8C7E-6041-48A6-8121-D1D6B18B6D0F}
// *********************************************************************//
  IDatabase = interface(IUnknown)
    ['{487C8C7E-6041-48A6-8121-D1D6B18B6D0F}']
    function Get_Table(const bsTableType: WideString; out pVal: ITable): HResult; stdcall;
    function CreateQuery(const bsQueryType: WideString; out pVal: IQuery): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ITable
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {3E97D2FB-EEC4-44D9-AD29-28ED456A48AF}
// *********************************************************************//
  ITable = interface(IUnknown)
    ['{3E97D2FB-EEC4-44D9-AD29-28ED456A48AF}']
    function Get_type_(out pVal: WideString): HResult; stdcall;
    function Get_RecordCount(out pVal: Integer): HResult; stdcall;
    function GetRecord(nIndex: Integer; out pVal: IDataRow): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDataRow
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {40D7E429-A27C-4F7E-A748-369F7BC19259}
// *********************************************************************//
  IDataRow = interface(IUnknown)
    ['{40D7E429-A27C-4F7E-A748-369F7BC19259}']
    function Get_type_(out pVal: WideString): HResult; stdcall;
    function Get_Index(out pVal: Integer): HResult; stdcall;
    function Get_Value(const bsName: WideString; out pVal: OleVariant): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IQuery
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {8FFA4E93-F2D8-4FE2-AAD2-59D7851EE92E}
// *********************************************************************//
  IQuery = interface(IUnknown)
    ['{8FFA4E93-F2D8-4FE2-AAD2-59D7851EE92E}']
    function AddCriterion(const bsName: WideString; newVal: OleVariant): HResult; stdcall;
    function Execute: HResult; stdcall;
    function Fetch(out pVal: IDataRow): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IBaseViewFrame
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {4C9EF3B1-E281-44B3-9454-868E37E92680}
// *********************************************************************//
  IBaseViewFrame = interface(IUnknown)
    ['{4C9EF3B1-E281-44B3-9454-868E37E92680}']
    function Get_HWindow(out pVal: OLE_HANDLE): HResult; stdcall;
    function Get_Map(out pVal: IMap): HResult; stdcall;
    function Get_AcceleratorTable(out pVal: IAcceleratorTable): HResult; stdcall;
    function Get_MainRibbonBar(out pVal: IRibbonBar): HResult; stdcall;
    function Get_CustomPageCollection(out pVal: ICustomPageCollection): HResult; stdcall;
    function Get_DirectoryCollection(out pVal: IDirectoryCollection): HResult; stdcall;
    function Get_ExecContext(out pVal: IContextBase): HResult; stdcall;
    function Get_ViewMode(out pVal: BaseFrameViewMode): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMap
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {4B99828C-3CB0-4BA4-8DCA-49929B497661}
// *********************************************************************//
  IMap = interface(IUnknown)
    ['{4B99828C-3CB0-4BA4-8DCA-49929B497661}']
    function Get_FullExtent(out pRect: IMapRect): HResult; stdcall;
    function ShowFullExtent: HResult; stdcall;
    function Invalidate(bForceRedraw: WordBool): HResult; stdcall;
    function ShowPos(const pPtMap: IMapPoint; nScale: Integer; bFlash: WordBool; 
                     bDisableFly: WordBool): HResult; stdcall;
    function SetMapVisibleRect(const newVal: IMapRect; bDisableFly: WordBool): HResult; stdcall;
    function GetMapVisibleRect(out pVal: IMapRect): HResult; stdcall;
    function Get_HWindow(out pVal: OLE_HANDLE): HResult; stdcall;
    function Get_Layers(out pVal: ILayerCollection): HResult; stdcall;
    function Get_Tools(out pVal: IMapTools): HResult; stdcall;
    function Get_ContextMenu(out pVal: IPopupMenu): HResult; stdcall;
    function CopyMap(const pSource: IDevRect; hDCDest: OLE_HANDLE; const pDest: IDevPoint): HResult; stdcall;
    function Get_CoordinateTransformation(out pVal: IUnknown): HResult; stdcall;
    function Get_MapInfoControllers(out pVal: IMapInfoControllers): HResult; stdcall;
    function GetSelection(const bsTag: WideString; bForceCreate: WordBool; out pVal: ISelection): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ILayerCollection
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {0F3D6150-F7AF-4738-9841-72898462E96E}
// *********************************************************************//
  ILayerCollection = interface(IUnknown)
    ['{0F3D6150-F7AF-4738-9841-72898462E96E}']
    function AddLayer(const pVal: ILayer): HResult; stdcall;
    function RemoveLayer(const pVal: ILayer): HResult; stdcall;
    function FindLayer(const bsTag: WideString; out pVal: ILayer): HResult; stdcall;
    function Get_MapInfoLayer(const pLayer: IGrymLayer; out pVal: IMapInfoLayer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ILayer
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {8F09FECA-F4EB-47EE-9EC1-23092F13025C}
// *********************************************************************//
  ILayer = interface(IUnknown)
    ['{8F09FECA-F4EB-47EE-9EC1-23092F13025C}']
    function Get_VisibleState(out pVal: WordBool): HResult; stdcall;
    function Set_VisibleState(pVal: WordBool): HResult; stdcall;
    function CheckVisible(nScale: Integer; nType: DeviceType; out pVal: WordBool): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IGrymLayer
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {43D3201E-CDCF-44DB-A599-18F0968858F0}
// *********************************************************************//
  IGrymLayer = interface(IUnknown)
    ['{43D3201E-CDCF-44DB-A599-18F0968858F0}']
    function Get_Table(out pVal: ITable): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMapInfoLayer
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {9557DC11-0B72-472D-9881-E8BE3B094BD8}
// *********************************************************************//
  IMapInfoLayer = interface(IUnknown)
    ['{9557DC11-0B72-472D-9881-E8BE3B094BD8}']
    function Register(const pVal: IMapInfoLayerBlock): HResult; stdcall;
    function Unregister(const pVal: IMapInfoLayerBlock): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMapInfoLayerBlock
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {1A3ED061-E7F0-48E4-93FE-199A7D867FB4}
// *********************************************************************//
  IMapInfoLayerBlock = interface(IUnknown)
    ['{1A3ED061-E7F0-48E4-93FE-199A7D867FB4}']
    function SetFiller(const pVal: IMapInfoLayerFiller): HResult; stdcall;
    function Get_MapInfoController(out pVal: IMapInfoController): HResult; stdcall;
    function Get_VisibleState(out pVal: WordBool): HResult; stdcall;
    function Set_VisibleState(pVal: WordBool): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMapInfoLayerFiller
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {0256A9C3-D993-455A-BFE7-08C027007511}
// *********************************************************************//
  IMapInfoLayerFiller = interface(IUnknown)
    ['{0256A9C3-D993-455A-BFE7-08C027007511}']
    function AddByID(nID: Integer): HResult; stdcall;
    function AddByFeature(const pFeature: IFeature): HResult; stdcall;
    function RemoveByID(nID: Integer): HResult; stdcall;
    function RemoveByFeature(const pFeature: IFeature): HResult; stdcall;
    function RemoveAll: HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IFeature
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {668433F9-1DA3-4C2B-8D76-C3EF6AD9CABC}
// *********************************************************************//
  IFeature = interface(IUnknown)
    ['{668433F9-1DA3-4C2B-8D76-C3EF6AD9CABC}']
    function Get_Layer(out pVal: ILayer): HResult; stdcall;
    function Get_CenterPoint(out pVal: IMapPoint): HResult; stdcall;
    function Get_BoundRect(out pVal: IMapRect): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMapInfoController
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {85572ACF-7A31-445A-8322-7448DA5DE7D5}
// *********************************************************************//
  IMapInfoController = interface(IUnknown)
    ['{85572ACF-7A31-445A-8322-7448DA5DE7D5}']
    function Check(const pFeature: IFeature; out pVal: WordBool): HResult; stdcall;
    function Get_Title(out pVal: WideString): HResult; stdcall;
    function Fill(const pFeature: IFeature; const pTab: ICalloutTab): HResult; stdcall;
    function OnTabAction(const pTab: ICalloutTab; const bsActionID: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ICalloutTab
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {1A8D4B37-2EAC-46DD-8A94-92187746D4B7}
// *********************************************************************//
  ICalloutTab = interface(IUnknown)
    ['{1A8D4B37-2EAC-46DD-8A94-92187746D4B7}']
    function Get_Callout(out pParent: ICallout): HResult; stdcall;
    function Get_Text(out pVal: WideString): HResult; stdcall;
    function Set_Text(const pVal: WideString): HResult; stdcall;
    function Get_Title(out pVal: WideString): HResult; stdcall;
    function Set_Title(const pVal: WideString): HResult; stdcall;
    function Get_Attribute(const bsElementID: WideString; const bsAttrName: WideString; 
                           out pVal: WideString): HResult; stdcall;
    function Set_Attribute(const bsElementID: WideString; const bsAttrName: WideString; 
                           const pVal: WideString): HResult; stdcall;
    function Get_TitleIcon(out pVal: IUnknown): HResult; stdcall;
    function _Set_TitleIcon(const pVal: IUnknown): HResult; stdcall;
    function Get_Images(out pVal: IRasterSet): HResult; stdcall;
    function _Set_Images(const pVal: IRasterSet): HResult; stdcall;
    function Get_StyleAttribute(const bsElementID: WideString; const bsAttrName: WideString; 
                                out pVal: WideString): HResult; stdcall;
    function Set_StyleAttribute(const bsElementID: WideString; const bsAttrName: WideString; 
                                const pVal: WideString): HResult; stdcall;
    function EnsureVisible(const bsElementID: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IGraphicBase
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {B97D5F78-CDE2-4165-BF8D-B87DB1B0FE8C}
// *********************************************************************//
  IGraphicBase = interface(IUnknown)
    ['{B97D5F78-CDE2-4165-BF8D-B87DB1B0FE8C}']
    function Get_Tag(out pVal: WideString): HResult; stdcall;
    function Set_Tag(const pVal: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ICallout
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {BD11517D-8D3B-4087-9FAE-554CDD3C24F6}
// *********************************************************************//
  ICallout = interface(IGraphicBase)
    ['{BD11517D-8D3B-4087-9FAE-554CDD3C24F6}']
    function Get_AutoClose(out pVal: WordBool): HResult; stdcall;
    function Set_AutoClose(pVal: WordBool): HResult; stdcall;
    function GetAnchor(out pVal: IMapPoint): HResult; stdcall;
    function GetVector(out pVal: IDevPoint): HResult; stdcall;
    function GetSize(out pVal: IDevSize): HResult; stdcall;
    function IsMapPointInside(const pPt: IMapPoint; out pVal: WordBool): HResult; stdcall;
    function AddStandardButton(nType: CalloutStandardButtonType; out pIndex: Integer): HResult; stdcall;
    function AddButton(const pBmpNormal: IRaster; out pIndex: Integer): HResult; stdcall;
    function AddCheckButton(const pBmpNormal: IRaster; const pBmpChecked: IRaster; 
                            bInitiallyChecked: WordBool; out pIndex: Integer): HResult; stdcall;
    function Get_ButtonChecked(nIndex: Integer; out pVal: WordBool): HResult; stdcall;
    function Set_ButtonChecked(nIndex: Integer; pVal: WordBool): HResult; stdcall;
    function Get_Title(out pVal: WideString): HResult; stdcall;
    function Set_Title(const pVal: WideString): HResult; stdcall;
    function AddTab(const tabTitle: WideString; out pVal: ICalloutTab): HResult; stdcall;
    function RemoveTab(const pTab: ICalloutTab; out bIsSuccess: WordBool): HResult; stdcall;
    function InsertTab(const pAfterTab: ICalloutTab; const tabTitle: WideString; 
                       out pVal: ICalloutTab): HResult; stdcall;
    function Get_ActiveTab(out pTab: ICalloutTab): HResult; stdcall;
    function _Set_ActiveTab(const pTab: ICalloutTab): HResult; stdcall;
    function Get_CustomData(out pVal: OleVariant): HResult; stdcall;
    function Set_CustomData(pVal: OleVariant): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMapTools
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {F3FA33A8-8FBD-4BB0-9721-789A09BE6897}
// *********************************************************************//
  IMapTools = interface(IUnknown)
    ['{F3FA33A8-8FBD-4BB0-9721-789A09BE6897}']
    function AddTool(const pVal: IToolBase): HResult; stdcall;
    function RemoveTool(const pVal: IToolBase): HResult; stdcall;
    function _Set_CurrentTool(const ppVal: IToolBase): HResult; stdcall;
    function Get_CurrentTool(out ppVal: IToolBase): HResult; stdcall;
    function FindTool(const bsTag: WideString; out pTool: IToolBase): HResult; stdcall;
    function SetDefaultTool: HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IToolBase
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {63E83B7E-B232-47EF-8535-F7C795933E1A}
// *********************************************************************//
  IToolBase = interface(IUnknown)
    ['{63E83B7E-B232-47EF-8535-F7C795933E1A}']
    function Get_Tag(out pVal: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMapInfoControllers
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {CE996283-7EC6-470A-AD18-00783626402F}
// *********************************************************************//
  IMapInfoControllers = interface(IUnknown)
    ['{CE996283-7EC6-470A-AD18-00783626402F}']
    function AddController(const pController: IMapInfoController): HResult; stdcall;
    function RemoveController(const pController: IMapInfoController): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISelection
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {673C253A-EC58-4A59-8171-CCA6005D318A}
// *********************************************************************//
  ISelection = interface(IUnknown)
    ['{673C253A-EC58-4A59-8171-CCA6005D318A}']
    function Get_Color(out pVal: OLE_COLOR): HResult; stdcall;
    function Set_Color(pVal: OLE_COLOR): HResult; stdcall;
    function Get_Count(out pVal: Integer): HResult; stdcall;
    function Get_Feature(nIndex: Integer; out pFeature: IFeature): HResult; stdcall;
    function AddFeature(const pFeature: IFeature): HResult; stdcall;
    function RemoveFeature(const pFeature: IFeature): HResult; stdcall;
    function RemoveAllFeatures: HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IAcceleratorTable
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {E0577C77-4D55-455D-8796-8664F400EA4E}
// *********************************************************************//
  IAcceleratorTable = interface(IControlSet)
    ['{E0577C77-4D55-455D-8796-8664F400EA4E}']
  end;

// *********************************************************************//
// Interface: IRibbonBar
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {B8513460-6DFA-4842-967D-0CC745A625EF}
// *********************************************************************//
  IRibbonBar = interface(IUnknown)
    ['{B8513460-6DFA-4842-967D-0CC745A625EF}']
    function Get_Tab(const bsTag: WideString; out pVal: IRibbonTab): HResult; stdcall;
    function CreateTab(const bsTag: WideString; const bsPlacementCode: WideString; 
                       const bsName: WideString; out pVal: IRibbonTab): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IRibbonTab
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {959D410B-CFFA-41F2-B354-E4AB948516F7}
// *********************************************************************//
  IRibbonTab = interface(IUnknown)
    ['{959D410B-CFFA-41F2-B354-E4AB948516F7}']
    function Get_Group(const bsTag: WideString; out pVal: IRibbonGroup): HResult; stdcall;
    function CreateGroup(nType: RibbonGroupType; const bsTag: WideString; 
                         const bsPlacementCode: WideString; const bsName: WideString; 
                         out pVal: IRibbonGroup): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IRibbonGroup
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {0BF550C7-CEAB-4AF2-B939-92B69C625413}
// *********************************************************************//
  IRibbonGroup = interface(IUnknown)
    ['{0BF550C7-CEAB-4AF2-B939-92B69C625413}']
    function SetIcon(const pIcon: IUnknown): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ICustomPageCollection
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {B92F4E88-BC43-49C7-BFAB-298EC73B62CF}
// *********************************************************************//
  ICustomPageCollection = interface(IUnknown)
    ['{B92F4E88-BC43-49C7-BFAB-298EC73B62CF}']
    function Get_Page(const bsTag: WideString; out pVal: ICustomPage): HResult; stdcall;
    function AddPage(const pPage: ICustomPage): HResult; stdcall;
    function RemovePage(const pPage: ICustomPage): HResult; stdcall;
    function ActivatePage(const pPage: ICustomPage): HResult; stdcall;
    function Get_ActivePage(out pVal: ICustomPage): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ICustomPage
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {D1A64629-C474-4FAD-9123-92C45B9252B5}
// *********************************************************************//
  ICustomPage = interface(IUnknown)
    ['{D1A64629-C474-4FAD-9123-92C45B9252B5}']
    function CanRemove(out pVal: WordBool): HResult; stdcall;
    function Get_Control(out pVal: IUnknown): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDirectoryCollection
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {1E933F83-308A-4D07-A0F5-AA93329B432B}
// *********************************************************************//
  IDirectoryCollection = interface(IUnknown)
    ['{1E933F83-308A-4D07-A0F5-AA93329B432B}']
    function AddDirectory(const pDirectory: IDirectory): HResult; stdcall;
    function RemoveDirectory(const pDirectory: IDirectory): HResult; stdcall;
    function Get_Directory(const bsTag: WideString; out pVal: IDirectory): HResult; stdcall;
    function Get_ActiveDirectory(out pVal: IDirectory): HResult; stdcall;
    function Search(const pCriteria: ICriteriaSet; const bsQueryCaption: WideString; 
                    const bsQueryDescription: WideString): HResult; stdcall;
    function _Set_ActiveDirectory(const pVal: IDirectory): HResult; stdcall;
    function Get_CurrentSearchCriteria(out pVal: ICriteriaSet): HResult; stdcall;
    function Get_CurrentSearchCaption(out pVal: WideString): HResult; stdcall;
    function Get_CurrentSearchDescription(out pVal: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDirectory
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {37B1AA55-E9B9-4A86-9985-4E6CA398D7CE}
// *********************************************************************//
  IDirectory = interface(IUnknown)
    ['{37B1AA55-E9B9-4A86-9985-4E6CA398D7CE}']
  end;

// *********************************************************************//
// Interface: IGrymControl
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {E15096D9-1A01-4AA2-B7E6-365E301BD826}
// *********************************************************************//
  IGrymControl = interface(IUnknown)
    ['{E15096D9-1A01-4AA2-B7E6-365E301BD826}']
    function Get_ControlType(out pVal: GrymControlType): HResult; stdcall;
    function Get_Style(out pVal: GrymControlStyle): HResult; stdcall;
    function Set_Style(pVal: GrymControlStyle): HResult; stdcall;
    function Get_Focused(out pVal: WordBool): HResult; stdcall;
    function Set_Focused(pVal: WordBool): HResult; stdcall;
    function Get_Width(out pVal: Integer): HResult; stdcall;
    function Set_Width(pVal: Integer): HResult; stdcall;
    function Get_Height(out pVal: Integer): HResult; stdcall;
    function Set_Height(pVal: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IGrymHTMLViewControl
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {45D8DFD5-00EF-4EE0-AF1F-6B0F01A650E9}
// *********************************************************************//
  IGrymHTMLViewControl = interface(IUnknown)
    ['{45D8DFD5-00EF-4EE0-AF1F-6B0F01A650E9}']
    function Set_Content(const pVal: WideString): HResult; stdcall;
    function Get_Content(out pVal: WideString): HResult; stdcall;
    function _Set_Images(const pVal: IRasterSet): HResult; stdcall;
    function Get_Images(out pVal: IRasterSet): HResult; stdcall;
    function SetAttribute(const bsElementID: WideString; const bsAttrName: WideString; 
                          const bsAttrVal: WideString): HResult; stdcall;
    function GetAttribute(const bsElementID: WideString; const bsAttrName: WideString; 
                          out pVal: WideString): HResult; stdcall;
    function SetStyleAttribute(const bsElementID: WideString; const bsAttrName: WideString; 
                               const bsAttrVal: WideString): HResult; stdcall;
    function GetStyleAttribute(const bsElementID: WideString; const bsAttrName: WideString; 
                               out pVal: WideString): HResult; stdcall;
    function Get_ContentSize(out pVal: IDevSize): HResult; stdcall;
    function EnsureVisible(const bsElementID: WideString): HResult; stdcall;
    function ModifyHTML(const bsElementID: WideString; mtVal: HTMLModificationType; 
                        const bsVal: WideString): HResult; stdcall;
    function ClientToScreen(const pClientCoord: IDevPoint; out pScreenCoord: IDevPoint): HResult; stdcall;
    function ScreenToClient(const pScreenCoord: IDevPoint; out pClientCoord: IDevPoint): HResult; stdcall;
    function GetElementIDByPos(const pClientCoord: IDevPoint; out pElementIDVal: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IShapeFill
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {C41BA6BB-66E5-4B2C-8497-38A26F056D1A}
// *********************************************************************//
  IShapeFill = interface(IUnknown)
    ['{C41BA6BB-66E5-4B2C-8497-38A26F056D1A}']
    function SetOID(nOID: Integer): HResult; stdcall;
    function AddComponent(nDim: ComponentDimension; vtXYs: OleVariant): HResult; stdcall;
    function AddPoint(nX: Double; nY: Double): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IStableTable
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {E128E783-9342-4F58-B272-55F650FCCA5C}
// *********************************************************************//
  IStableTable = interface(ITable)
    ['{E128E783-9342-4F58-B272-55F650FCCA5C}']
    function GetRecordByStableID(nStableID: Integer; out pVal: IDataRow): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IGrymObjectFactory2
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {39099042-45D5-47AB-ADA5-6803865F5FBD}
// *********************************************************************//
  IGrymObjectFactory2 = interface(IGrymObjectFactory)
    ['{39099042-45D5-47AB-ADA5-6803865F5FBD}']
    function CreateGrymControl(nType: GrymControlType; out pVal: IGrymControl): HResult; stdcall;
    function CreateRasterBagFromMemory(saVal: PSafeArray; out pResult: IRasterBag): HResult; stdcall;
    function CreateGrymHTMLViewControl(out pResult: IGrymHTMLViewControl): HResult; stdcall;
    function CreateShape(out pResult: IShapeFill): HResult; stdcall;
    function CreateFeature(const pLayer: ILayer; nIndex: Integer; out pVal: IFeature): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IGrymObjectFactoryDeprecated
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {9530BC2D-E492-4CD4-BB88-08D48575F91D}
// *********************************************************************//
  IGrymObjectFactoryDeprecated = interface(IUnknown)
    ['{9530BC2D-E492-4CD4-BB88-08D48575F91D}']
    function CreateQuery(const bsQueryType: WideString; out pVal: IQuery): HResult; stdcall;
    function CreateRasterFromHandle(hBitmap: OLE_HANDLE; out pResult: IRaster): HResult; stdcall;
    function CreateRasterFromIcon(hIcon: OLE_HANDLE; out pResult: IRaster): HResult; stdcall;
    function CreateRasterFromImageList(hImageList: OLE_HANDLE; nIndex: Integer; out pResult: IRaster): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IGrymPluginInfo
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {ABFDF706-F8B1-4145-BC75-528F232321B3}
// *********************************************************************//
  IGrymPluginInfo = interface(IUnknown)
    ['{ABFDF706-F8B1-4145-BC75-528F232321B3}']
    function Get_XMLInfo(out pData: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IGrymPluginOptions
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {A8098FA0-A4BD-433E-93A6-BD05A1C6F288}
// *********************************************************************//
  IGrymPluginOptions = interface(IUnknown)
    ['{A8098FA0-A4BD-433E-93A6-BD05A1C6F288}']
    function OptionDialog(out pRet: WordBool): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  _IBaseCollectionEvents
// Flags:     (4096) Dispatchable
// GUID:      {98E734EB-E693-402E-807B-FBDC6FE183BA}
// *********************************************************************//
  _IBaseCollectionEvents = dispinterface
    ['{98E734EB-E693-402E-807B-FBDC6FE183BA}']
    procedure OnCollectionChanged; dispid 1;
  end;

// *********************************************************************//
// Interface: IScalableSymbol
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {263D2C76-5955-4220-A59C-A53D6886F35F}
// *********************************************************************//
  IScalableSymbol = interface(IUnknown)
    ['{263D2C76-5955-4220-A59C-A53D6886F35F}']
    function Get_Scalable(out pVal: WordBool): HResult; stdcall;
    function Set_Scalable(pVal: WordBool): HResult; stdcall;
    function Get_ReferenceScale(out pVal: Integer): HResult; stdcall;
    function Set_ReferenceScale(pVal: Integer): HResult; stdcall;
    function Get_MinScale(out pVal: Integer): HResult; stdcall;
    function Set_MinScale(pVal: Integer): HResult; stdcall;
    function Get_MaxScale(out pVal: Integer): HResult; stdcall;
    function Set_MaxScale(pVal: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IGraphicCustom
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {EF2633EE-C59F-40C1-B14A-E9C31202BDB4}
// *********************************************************************//
  IGraphicCustom = interface(IGraphicBase)
    ['{EF2633EE-C59F-40C1-B14A-E9C31202BDB4}']
    function OnRemove: HResult; stdcall;
    function Draw(const pDevice: IMapDevice): HResult; stdcall;
    function GetBoundRect(const pDevice: IMapDevice; out ppDevExt: IDevRect): HResult; stdcall;
    function IsMapPointInside(const pPos: IMapPoint; out pVal: WordBool): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ICalloutTab2
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {66491A2F-4254-4034-9AB7-69E8FAE5B023}
// *********************************************************************//
  ICalloutTab2 = interface(ICalloutTab)
    ['{66491A2F-4254-4034-9AB7-69E8FAE5B023}']
    function ModifyHTML(const bsElementID: WideString; mtVal: HTMLModificationType; 
                        const bsVal: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ICalloutTab3
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {172A3F61-4BE1-4EBB-A84E-493D2E910013}
// *********************************************************************//
  ICalloutTab3 = interface(ICalloutTab2)
    ['{172A3F61-4BE1-4EBB-A84E-493D2E910013}']
    function Get_Description(out pVal: WideString): HResult; stdcall;
    function Set_Description(const pVal: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IPluginShapeCursor
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {F600D260-61C2-4459-9B53-26D3B693A30E}
// *********************************************************************//
  IPluginShapeCursor = interface(IUnknown)
    ['{F600D260-61C2-4459-9B53-26D3B693A30E}']
    function Next(const pShape: IShapeFill; out pOk: WordBool): HResult; stdcall;
    function Get_ShapeInfo(out pVal: WideString): HResult; stdcall;
    function Get_Label_(out pVal: WideString): HResult; stdcall;
    function Get_LabelAnchor(out pVal: IMapPoint): HResult; stdcall;
    function Get_TextSymbol(out pVal: ITextSymbol): HResult; stdcall;
    function Get_MarkerSymbol(out pVal: IMarkerSymbol): HResult; stdcall;
    function Get_LineSymbol(out pVal: ILineSymbol): HResult; stdcall;
    function Get_FillSymbol(out pVal: IFillSymbol): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IPluginShapeLayer
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {26ED95F2-16B1-4DB9-8A47-E15166728AC4}
// *********************************************************************//
  IPluginShapeLayer = interface(IUnknown)
    ['{26ED95F2-16B1-4DB9-8A47-E15166728AC4}']
    function CheckLabelVisible(lScale: Integer; devType: DeviceType; out pVal: WordBool): HResult; stdcall;
    function Get_Selectable(out pVal: WordBool): HResult; stdcall;
    function Get_ScalableSymbol(out pVal: WordBool): HResult; stdcall;
    function Get_ReferenceScale(out pVal: Integer): HResult; stdcall;
    function QueryShapes(const pRect: IMapRect; out pCursor: IPluginShapeCursor): HResult; stdcall;
    function QueryShapeById(nOID: Integer; out pCursor: IPluginShapeCursor): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IPluginCustomDrawLayer
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {6D66C802-6D2F-4249-B752-1BDB5D15D82C}
// *********************************************************************//
  IPluginCustomDrawLayer = interface(IUnknown)
    ['{6D66C802-6D2F-4249-B752-1BDB5D15D82C}']
    function Draw(const device: IMapDevice): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMapInfoControllers2
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {FBE77A92-5309-49A7-B766-CF90D3D4A64F}
// *********************************************************************//
  IMapInfoControllers2 = interface(IMapInfoControllers)
    ['{FBE77A92-5309-49A7-B766-CF90D3D4A64F}']
    function FindMapInfoController(const bsTag: WideString; out pVal: IMapInfoController): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMapInfoDirOrgFilter
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {AFD535FF-E560-4786-A9F0-C8492F08ED9F}
// *********************************************************************//
  IMapInfoDirOrgFilter = interface(IUnknown)
    ['{AFD535FF-E560-4786-A9F0-C8492F08ED9F}']
    function Check(const pOrgRecord: IDataRow; bInCurrentSelection: WordBool; out pValid: WordBool): HResult; stdcall;
    function GetOrgIcon(const pOrgRecord: IDataRow; bInCurrentSelection: WordBool; 
                        out pVal: WideString): HResult; stdcall;
    function Get_Title(out pVal: WideString): HResult; stdcall;
    function Get_TitleIcon(out pVal: WideString): HResult; stdcall;
    function Get_Images(out pVal: IRasterSet): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMapInfoActionsCustomizer
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {41667FDC-A081-4B5D-A076-65AA280CAE77}
// *********************************************************************//
  IMapInfoActionsCustomizer = interface(IUnknown)
    ['{41667FDC-A081-4B5D-A076-65AA280CAE77}']
    function MakeActions(const pFeature: IFeature; out pVal: WideString): HResult; stdcall;
    function Get_Images(out pVal: IRasterSet): HResult; stdcall;
    function OnAction(const pFeature: IFeature; const bsAction: WideString; out pDone: WordBool): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IPopupMenuMapViewContext
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {FA96FE13-33A3-4F02-97C2-FADB29172836}
// *********************************************************************//
  IPopupMenuMapViewContext = interface(IUnknown)
    ['{FA96FE13-33A3-4F02-97C2-FADB29172836}']
    function Get_ScreenPos(out pVal: IDevPoint): HResult; stdcall;
    function Get_ClientPos(out pVal: IDevPoint): HResult; stdcall;
    function Get_MapPos(out pVal: IMapPoint): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IGrymToolRadius
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {CD682230-8E2D-43BA-90F9-A00260AF9E78}
// *********************************************************************//
  IGrymToolRadius = interface(IToolBase)
    ['{CD682230-8E2D-43BA-90F9-A00260AF9E78}']
    function Get_Radius(out pVal: Double): HResult; stdcall;
    function Get_CenterPoint(out ppVal: IMapPoint): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ITool
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {8B25C9C9-5FD8-4C6D-B8A3-AF12FDD17C3A}
// *********************************************************************//
  ITool = interface(IToolBase)
    ['{8B25C9C9-5FD8-4C6D-B8A3-AF12FDD17C3A}']
    function Get_Cursor(out pCursor: OLE_HANDLE): HResult; stdcall;
    function Activate(bActivate: WordBool; out pOk: WordBool): HResult; stdcall;
    function OnKeyDown(nChar: Integer; nShift: Integer; out pHandled: WordBool): HResult; stdcall;
    function OnKeyUp(nChar: Integer; nShift: Integer; out pHandled: WordBool): HResult; stdcall;
    function OnMouseDown(nButton: MouseButton; nShift: Integer; nX: Integer; nY: Integer; 
                         out pHandled: WordBool): HResult; stdcall;
    function OnMouseDblClk(nButton: MouseButton; nShift: Integer; nX: Integer; nY: Integer; 
                           out pHandled: WordBool): HResult; stdcall;
    function OnMouseUp(nButton: MouseButton; nShift: Integer; nX: Integer; nY: Integer; 
                       out pHandled: WordBool): HResult; stdcall;
    function OnMouseMove(nShift: Integer; nX: Integer; nY: Integer; out pHandled: WordBool): HResult; stdcall;
    function OnClick(nX: Integer; nY: Integer): HResult; stdcall;
    function OnDraw(const pDevice: IMapDevice): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMapCoordinateTransformationGeo
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {E83B7E24-40C7-4845-AF23-52CB4D423C49}
// *********************************************************************//
  IMapCoordinateTransformationGeo = interface(IUnknown)
    ['{E83B7E24-40C7-4845-AF23-52CB4D423C49}']
    function LocalToGeo(const pSrcLocal: IMapPoint; out pResultGeo: IMapPoint): HResult; stdcall;
    function GeoToLocal(const pSrcGeo: IMapPoint; out pResultLocal: IMapPoint): HResult; stdcall;
    function Get_Spheroid(out pVal: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMapCoordinateTransformationUTM
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {F004BAFA-50C8-46F4-A565-DD70DDD9A0FD}
// *********************************************************************//
  IMapCoordinateTransformationUTM = interface(IUnknown)
    ['{F004BAFA-50C8-46F4-A565-DD70DDD9A0FD}']
    function LocalToUTM(const pSrcLocal: IMapPoint; out pResultUTM: IMapPoint): HResult; stdcall;
    function UTMToLocal(const pSrcUTM: IMapPoint; out pResultLocal: IMapPoint): HResult; stdcall;
    function Get_Zone(out pVal: WideString): HResult; stdcall;
    function Get_MapCoordinateTransformationGeo(out pVal: IMapCoordinateTransformationGeo): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMapGraphics
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {16AA5C37-04B2-4E9E-BB28-916A66B91504}
// *********************************************************************//
  IMapGraphics = interface(IUnknown)
    ['{16AA5C37-04B2-4E9E-BB28-916A66B91504}']
    function CreateCallout(const pPtAnchor: IMapPoint; bAutoClose: WordBool; 
                           const pVector: IDevPoint; const pSize: IDevSize; out pResult: ICallout): HResult; stdcall;
    function AddGraphic(const pGraphic: IGraphicBase): HResult; stdcall;
    function RemoveGraphic(const pGraphic: IGraphicBase): HResult; stdcall;
    function BringToFront(const pGraphic: IGraphicBase; bRedraw: WordBool): HResult; stdcall;
    function SendToBack(const pGraphic: IGraphicBase; bRedraw: WordBool): HResult; stdcall;
    function Get_GraphicCount(out pVal: Integer): HResult; stdcall;
    function Get_GraphicByIndex(nIndex: Integer; out pVal: IGraphicBase): HResult; stdcall;
    function Get_GraphicByPosition(const pPosition: IMapPoint; out pVal: IGraphicBase): HResult; stdcall;
    function Get_GraphicByTag(const bsTag: WideString; out pVal: IGraphicBase): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMapInfoLayerFiller2
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {F81CA815-BACE-42D8-A8EC-B07D89FB7EE6}
// *********************************************************************//
  IMapInfoLayerFiller2 = interface(IMapInfoLayerFiller)
    ['{F81CA815-BACE-42D8-A8EC-B07D89FB7EE6}']
    function AddByID2(nID: Integer; const pRaster: IRaster): HResult; stdcall;
    function AddByFeature2(const pFeature: IFeature; const pRaster: IRaster): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMapInfoLayerFiller3
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {D1A260DE-D627-4AD9-95D9-E27F75E194F6}
// *********************************************************************//
  IMapInfoLayerFiller3 = interface(IMapInfoLayerFiller2)
    ['{D1A260DE-D627-4AD9-95D9-E27F75E194F6}']
    function AddByID3(nID: Integer; const pRaster: IRaster; nPriority: Integer): HResult; stdcall;
    function AddByFeature3(const pFeature: IFeature; const pRaster: IRaster; nPriority: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMapInfoLayerBlockProp
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {07B67917-D5C7-40AF-8417-25767A9E250A}
// *********************************************************************//
  IMapInfoLayerBlockProp = interface(IUnknown)
    ['{07B67917-D5C7-40AF-8417-25767A9E250A}']
    function CheckVisible(lScale: Integer; nType: DeviceType; out pVal: WordBool): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMap2
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {E782F45E-98E2-47DB-8D61-3E9578E78AD4}
// *********************************************************************//
  IMap2 = interface(IMap)
    ['{E782F45E-98E2-47DB-8D61-3E9578E78AD4}']
    function CreateInfoCard(const pIdentifySource: IFeature; out pVal: ICallout): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  _ICalloutEvents
// Flags:     (4096) Dispatchable
// GUID:      {5F45AD9C-B2F8-4DC8-8F66-A064E900FFDB}
// *********************************************************************//
  _ICalloutEvents = dispinterface
    ['{5F45AD9C-B2F8-4DC8-8F66-A064E900FFDB}']
    procedure OnClose; dispid 1;
    procedure OnButtonAction(nIndex: Integer); dispid 2;
  end;

// *********************************************************************//
// DispIntf:  _ICalloutTabEvents
// Flags:     (4096) Dispatchable
// GUID:      {5FB3D6E9-48DD-4A7B-B049-5E9C5FA51CF8}
// *********************************************************************//
  _ICalloutTabEvents = dispinterface
    ['{5FB3D6E9-48DD-4A7B-B049-5E9C5FA51CF8}']
    procedure OnAction(const bsActionID: WideString); dispid 1;
    procedure OnDestroyed; dispid 2;
    procedure OnLeftMouseButtonClick(const bsBlockID: WideString); dispid 3;
  end;

// *********************************************************************//
// Interface: ISpatialFilter
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {31AEA029-7E7B-44B7-80DE-AFD0F1190D3B}
// *********************************************************************//
  ISpatialFilter = interface(IUnknown)
    ['{31AEA029-7E7B-44B7-80DE-AFD0F1190D3B}']
    function Check(const pPos: IMapPoint; out pVal: WordBool): HResult; stdcall;
    function Get_Bounds(out pVal: IMapRect): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDirectoryViewCellControllerProp
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {99A4FD24-CF2E-44CB-A3A8-E326D18C93DA}
// *********************************************************************//
  IDirectoryViewCellControllerProp = interface(IUnknown)
    ['{99A4FD24-CF2E-44CB-A3A8-E326D18C93DA}']
    function Get_Flags(out pVal: Integer): HResult; stdcall;
    function Set_Flags(pVal: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDirectoryExpandableViewCellController
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {7855C715-DCBB-4998-A575-C7F4307B79AF}
// *********************************************************************//
  IDirectoryExpandableViewCellController = interface(IUnknown)
    ['{7855C715-DCBB-4998-A575-C7F4307B79AF}']
    function Get_CanExpand(out pVal: WordBool): HResult; stdcall;
    function Get_CanCollapse(out pVal: WordBool): HResult; stdcall;
    function Expand: HResult; stdcall;
    function Collapse: HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDirectoryClipboardViewCellController
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {07413F58-659B-4233-A49D-ABA1EECEFBB8}
// *********************************************************************//
  IDirectoryClipboardViewCellController = interface(IUnknown)
    ['{07413F58-659B-4233-A49D-ABA1EECEFBB8}']
    function MakeClipboardContentText(out pVal: WideString): HResult; stdcall;
    function MakeClipboardContentHTML(out pVal: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDirectorySearchCursor
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {1D0C5342-9AE5-48FB-BB8A-E7530DF641F3}
// *********************************************************************//
  IDirectorySearchCursor = interface(IUnknown)
    ['{1D0C5342-9AE5-48FB-BB8A-E7530DF641F3}']
    function Next(out pVal: IDirectoryViewCellController): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDirectoryService
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {52EC6A48-C44E-43C2-807F-9D3403DDAB0E}
// *********************************************************************//
  IDirectoryService = interface(IUnknown)
    ['{52EC6A48-C44E-43C2-807F-9D3403DDAB0E}']
    function Get_PersonalToolbar(out pToolbar: IControlSet): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDirectoryEx
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {C1CB6B80-9AE1-425E-B211-B66FDF5D0B20}
// *********************************************************************//
  IDirectoryEx = interface(IUnknown)
    ['{C1CB6B80-9AE1-425E-B211-B66FDF5D0B20}']
    function SetDirectoryService(const pService: IDirectoryService): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDirectoryCustom
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {9ABE39D8-9045-4091-A2F6-4F6EE763A92F}
// *********************************************************************//
  IDirectoryCustom = interface(IDirectory)
    ['{9ABE39D8-9045-4091-A2F6-4F6EE763A92F}']
    function CanRemove(out pVal: WordBool): HResult; stdcall;
    function Get_MinWidth(out pVal: Integer): HResult; stdcall;
    function Get_ViewCellFactory(out pVal: IDirectoryViewCellFactory): HResult; stdcall;
    function Search(const pCriteria: ICriteriaSet; out pVal: IDirectorySearchCursor): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDirectoryHTMLViewCell
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {40FF86FB-777E-4ABF-A9B9-08249FDB0966}
// *********************************************************************//
  IDirectoryHTMLViewCell = interface(IUnknown)
    ['{40FF86FB-777E-4ABF-A9B9-08249FDB0966}']
    function Update: HResult; stdcall;
    function GetParentElementID(const bsElementID: WideString; out pVal: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDirectoryHTMLViewCellController
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {3D918276-3714-49DE-A4C9-28FB726221D7}
// *********************************************************************//
  IDirectoryHTMLViewCellController = interface(IUnknown)
    ['{3D918276-3714-49DE-A4C9-28FB726221D7}']
    function MakeContent(out pVal: WideString): HResult; stdcall;
    function Get_Images(out pVal: IRasterSet): HResult; stdcall;
    function OnSetCursor(const bsElementID: WideString; out bDone: WordBool): HResult; stdcall;
    function OnLink(const bsID: WideString): HResult; stdcall;
    function OnClick(const bsElementID: WideString): HResult; stdcall;
    function FillContextMenu(const bsElementID: WideString; const pMenu: IMenu): HResult; stdcall;
    function HitTest(const bsElementID: WideString; const pHitTestFill: IHitTestFill; 
                     out bDone: WordBool): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDirectoryPrintableViewCellController
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {635AEF1B-C068-4E06-8C5A-ADD3ABA4682A}
// *********************************************************************//
  IDirectoryPrintableViewCellController = interface(IUnknown)
    ['{635AEF1B-C068-4E06-8C5A-ADD3ABA4682A}']
    function Get_CanPrint(out pVal: WordBool): HResult; stdcall;
    function MakePrintContent(out pVal: WideString): HResult; stdcall;
    function Get_PrintImages(out pVal: IRasterSet): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IStdDirectoryCustomControllerContainer
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {C6F3064C-39C8-4394-ADC9-A0920444624C}
// *********************************************************************//
  IStdDirectoryCustomControllerContainer = interface(IUnknown)
    ['{C6F3064C-39C8-4394-ADC9-A0920444624C}']
    function RegisterController(const pVal: IUnknown): HResult; stdcall;
    function UnregisterController(const pVal: IUnknown): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IStdDirectoryDataRowFilter
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {36012FDB-8C0D-46B9-9BED-DED2A204B439}
// *********************************************************************//
  IStdDirectoryDataRowFilter = interface(IUnknown)
    ['{36012FDB-8C0D-46B9-9BED-DED2A204B439}']
    function Check(const pRecord: IDataRow; out pVal: WordBool): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IStdDirectoryQuickFilter
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {8180847E-7ED4-4109-8891-0728E540446B}
// *********************************************************************//
  IStdDirectoryQuickFilter = interface(IUnknown)
    ['{8180847E-7ED4-4109-8891-0728E540446B}']
    function SkipCount(nIndex: Integer; out pVal: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IStdDirectoryQueryCustomize
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {747C4429-69BC-4421-9841-4140CEFECE3D}
// *********************************************************************//
  IStdDirectoryQueryCustomize = interface(IUnknown)
    ['{747C4429-69BC-4421-9841-4140CEFECE3D}']
    function AddFilter(const pFilter: IUnknown): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IStdDirectoryCustomFilterController
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {EDACEE87-7A5F-426B-8917-CBAA0C153236}
// *********************************************************************//
  IStdDirectoryCustomFilterController = interface(IUnknown)
    ['{EDACEE87-7A5F-426B-8917-CBAA0C153236}']
    function CustomizeQuery(const pCriterion: IDirectoryCriteriaHelper; 
                            const pQuery: IStdDirectoryQueryCustomize): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IStdDirectoryCellInfo
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {51BEC9FC-D3A4-404A-9085-E0DB30C2D046}
// *********************************************************************//
  IStdDirectoryCellInfo = interface(IUnknown)
    ['{51BEC9FC-D3A4-404A-9085-E0DB30C2D046}']
    function Get_Record_(out pVal: IDataRow): HResult; stdcall;
    function Update: HResult; stdcall;
    function GetHTMLParentElementID(const bsElementID: WideString; out pVal: WideString): HResult; stdcall;
    function Get_Expanded(out pVal: WordBool): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IStdDirectoryCellCustomController
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {166C0B21-2A8F-42C8-8555-2EC5AD66276A}
// *********************************************************************//
  IStdDirectoryCellCustomController = interface(IUnknown)
    ['{166C0B21-2A8F-42C8-8555-2EC5AD66276A}']
    function OnAttachToView(const pCellInfo: IStdDirectoryCellInfo): HResult; stdcall;
    function OnDetachFromView(const pCellInfo: IStdDirectoryCellInfo): HResult; stdcall;
    function GetImages(nContentType: CellAdditionalContentType; 
                       const pCellInfo: IStdDirectoryCellInfo; out pVal: IRasterSet): HResult; stdcall;
    function MakeAdditionalContent(nContentType: CellAdditionalContentType; 
                                   const pCellInfo: IStdDirectoryCellInfo; const pRecord: IDataRow; 
                                   out pVal: WideString): HResult; stdcall;
    function OnSetCursor(const pCellInfo: IStdDirectoryCellInfo; const bsElementID: WideString; 
                         out bDone: WordBool): HResult; stdcall;
    function OnLink(const pCellInfo: IStdDirectoryCellInfo; const bsID: WideString; 
                    out bDone: WordBool): HResult; stdcall;
    function OnClick(const pCellInfo: IStdDirectoryCellInfo; const bsElementID: WideString; 
                     out bDone: WordBool): HResult; stdcall;
    function FillContextMenu(const pCellInfo: IStdDirectoryCellInfo; const bsElementID: WideString; 
                             const pMenu: IMenu): HResult; stdcall;
    function HitTest(const pCellInfo: IStdDirectoryCellInfo; const bsElementID: WideString; 
                     const pHitTestFill: IHitTestFill; out bDone: WordBool): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IStdDirectoryCustomController
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {C399EC71-9A5A-4AB2-8070-AD284C811901}
// *********************************************************************//
  IStdDirectoryCustomController = interface(IUnknown)
    ['{C399EC71-9A5A-4AB2-8070-AD284C811901}']
    function MakeCellController(const pVal: IStdDirectoryCellInfo; 
                                out pPersonalController: IStdDirectoryCellCustomController): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IGrymControlAutoSuggestionComboBox
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {C5914DAD-685F-47A3-A135-8F6B8B47819C}
// *********************************************************************//
  IGrymControlAutoSuggestionComboBox = interface(IUnknown)
    ['{C5914DAD-685F-47A3-A135-8F6B8B47819C}']
    function SetAutoSuggestionController(const pVal: IAutoSuggestionComboBoxController): HResult; stdcall;
    function Get_Empty(out pVal: WordBool): HResult; stdcall;
    function Get_CurSel(out pVal: OleVariant): HResult; stdcall;
    function ResetContent: HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IAutoSuggestionComboBoxController
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {FCFC5ECB-ED58-47AD-B4D9-1E0E3DC912BA}
// *********************************************************************//
  IAutoSuggestionComboBoxController = interface(IUnknown)
    ['{FCFC5ECB-ED58-47AD-B4D9-1E0E3DC912BA}']
    function Get_MinSymbolsCount(out pVal: Integer): HResult; stdcall;
    function FillCombo(const bsStringPart: WideString; 
                       const pComboFiller: IAutoSuggestionComboBoxFiller): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IAutoSuggestionComboBoxFiller
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {A4B83821-0EDA-455E-AC38-48D89309A620}
// *********************************************************************//
  IAutoSuggestionComboBoxFiller = interface(IUnknown)
    ['{A4B83821-0EDA-455E-AC38-48D89309A620}']
    function AddString(const bsVal: WideString; varData: OleVariant): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ILegend
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {D29EEA28-E455-4057-AAEA-8BD472406A8C}
// *********************************************************************//
  ILegend = interface(IUnknown)
    ['{D29EEA28-E455-4057-AAEA-8BD472406A8C}']
    function AddElement(const pVal: ILegendItem): HResult; stdcall;
    function RemoveElement(const pVal: ILegendItem): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ILegendItem
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {AB995D08-B1A9-448A-8DFE-B581CF2B7835}
// *********************************************************************//
  ILegendItem = interface(IUnknown)
    ['{AB995D08-B1A9-448A-8DFE-B581CF2B7835}']
    function Get_VisibleState(out pVal: WordBool): HResult; stdcall;
    function Set_VisibleState(pVal: WordBool): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IContextBase2
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {24DA589D-B826-47DD-80F4-8040FDF4BF7A}
// *********************************************************************//
  IContextBase2 = interface(IContextBase)
    ['{24DA589D-B826-47DD-80F4-8040FDF4BF7A}']
    function LockCustomInfo(const bsKey: WideString; newVal: OleVariant): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IControlPlacement
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {2017A77A-043B-48A0-B3EA-F0504EC6CB2B}
// *********************************************************************//
  IControlPlacement = interface(IUnknown)
    ['{2017A77A-043B-48A0-B3EA-F0504EC6CB2B}']
    function Get_PlacementCode(out pVal: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IControlAppearance
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {4F46696D-9CCF-4953-B936-31E5B8763044}
// *********************************************************************//
  IControlAppearance = interface(IUnknown)
    ['{4F46696D-9CCF-4953-B936-31E5B8763044}']
    function Get_Tag(out pVal: WideString): HResult; stdcall;
    function Get_Caption(out pVal: WideString): HResult; stdcall;
    function Get_Description(out pVal: WideString): HResult; stdcall;
    function Get_Icon(out pVal: IUnknown): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IControlState
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {37F40CEC-1672-4032-904E-E7DA15327620}
// *********************************************************************//
  IControlState = interface(IUnknown)
    ['{37F40CEC-1672-4032-904E-E7DA15327620}']
    function Get_Available(out pVal: WordBool): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ICommandState
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {6C91FE90-B064-48B0-A4B2-4A2EBDC94DE7}
// *********************************************************************//
  ICommandState = interface(IControlState)
    ['{6C91FE90-B064-48B0-A4B2-4A2EBDC94DE7}']
    function Get_Enabled(out pVal: WordBool): HResult; stdcall;
    function Get_Checked(out pVal: WordBool): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ICommandAccelerator
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {0C043BDE-73D5-4049-A1DF-6B26F01D1FD1}
// *********************************************************************//
  ICommandAccelerator = interface(IUnknown)
    ['{0C043BDE-73D5-4049-A1DF-6B26F01D1FD1}']
    function Get_Accelerator(out pVal: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ICommandAction
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {56C38587-A7D2-4508-A35C-DA0249EE6645}
// *********************************************************************//
  ICommandAction = interface(IUnknown)
    ['{56C38587-A7D2-4508-A35C-DA0249EE6645}']
    function OnCommand: HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ICommandQuickAccessOptions
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {572796F9-EFE2-4C91-A670-C4966E3DC9E2}
// *********************************************************************//
  ICommandQuickAccessOptions = interface(IUnknown)
    ['{572796F9-EFE2-4C91-A670-C4966E3DC9E2}']
    function IsQuickAccessEnabled(out pBool: WordBool): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ICommandPopup
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {48BD529A-7AD1-4416-99A1-29EC9EE2558E}
// *********************************************************************//
  ICommandPopup = interface(IUnknown)
    ['{48BD529A-7AD1-4416-99A1-29EC9EE2558E}']
    function Get_PopupControl(out pVal: IUnknown): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IChildControl
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {5EE60AD6-BB89-4780-9848-ADE9B8CED065}
// *********************************************************************//
  IChildControl = interface(IUnknown)
    ['{5EE60AD6-BB89-4780-9848-ADE9B8CED065}']
    function Get_ParentControl(out pVal: IUnknown): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IRibbonGroup2
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {F041D1D2-D14E-46EB-95D6-80F4982D59A8}
// *********************************************************************//
  IRibbonGroup2 = interface(IRibbonGroup)
    ['{F041D1D2-D14E-46EB-95D6-80F4982D59A8}']
    function Get_OptionsCommand(out pVal: IUnknown): HResult; stdcall;
    function _Set_OptionsCommand(const pVal: IUnknown): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISearchRibbonGroup
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {677540CD-6416-40CF-94AE-826AECF2DEAB}
// *********************************************************************//
  ISearchRibbonGroup = interface(IUnknown)
    ['{677540CD-6416-40CF-94AE-826AECF2DEAB}']
    function SetGroupImage(const pIcon: IUnknown): HResult; stdcall;
    function SetSearchButtonTooltips(const bsTooltip: WideString; 
                                     const bsTooltipDisabled: WideString): HResult; stdcall;
    function SetClearButtonTooltips(const bsTooltip: WideString; const bsTooltipDisabled: WideString): HResult; stdcall;
    function IsSearchEnabled(out pVal: WordBool): HResult; stdcall;
    function IsClearEnabled(out pVal: WordBool): HResult; stdcall;
    function DoSearch: HResult; stdcall;
    function ClearAll: HResult; stdcall;
    function SetQueryDescription(const bsTitle: WideString; const bsText: WideString): HResult; stdcall;
    function SetGroupImageTooltip(const bsTooltip: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IRibbonGroupControl
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {1729520F-168D-4D6F-801E-BA2208105662}
// *********************************************************************//
  IRibbonGroupControl = interface(IUnknown)
    ['{1729520F-168D-4D6F-801E-BA2208105662}']
    function Clone(out pVal: IRibbonGroupControl): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISearchGroupControl
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {2ACC3822-A8E5-4843-9DAC-A7DEEE43D64A}
// *********************************************************************//
  ISearchGroupControl = interface(IUnknown)
    ['{2ACC3822-A8E5-4843-9DAC-A7DEEE43D64A}']
    function Get_SearchEnabled(out pVal: WordBool): HResult; stdcall;
    function Get_ClearEnabled(out pVal: WordBool): HResult; stdcall;
    function FillCriteriaSet(const pCritSet: ICriteriaSet; out pVal: WordBool): HResult; stdcall;
    function Get_SearchDescription(out pVal: WideString): HResult; stdcall;
    function Get_SearchCaption(out pVal: WideString): HResult; stdcall;
    function Clear: HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IBaseViewFrame2
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {BB5B7064-A01A-4BFF-8B0C-0D91584DAD33}
// *********************************************************************//
  IBaseViewFrame2 = interface(IBaseViewFrame)
    ['{BB5B7064-A01A-4BFF-8B0C-0D91584DAD33}']
    function ShowRubricator(const bsInitial: WideString; out pVal: IDataRow): HResult; stdcall;
    function Get_Legend(out pVal: ILegend): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IContainerControl
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {198AFA7C-A6CA-41C0-909A-C1F4E9D16E69}
// *********************************************************************//
  IContainerControl = interface(IUnknown)
    ['{198AFA7C-A6CA-41C0-909A-C1F4E9D16E69}']
    function Get_InternalControl(out pVal: IUnknown): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IGrymControlEditHintHolder
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {233F678C-2188-42F3-9E19-6D166F70CE8C}
// *********************************************************************//
  IGrymControlEditHintHolder = interface(IUnknown)
    ['{233F678C-2188-42F3-9E19-6D166F70CE8C}']
    function Get_EditHint(out pVal: WideString): HResult; stdcall;
    function Set_EditHint(const pVal: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IGrymControlEditTextHolder
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {6960289E-78CF-4976-9E0D-6A654282DDAD}
// *********************************************************************//
  IGrymControlEditTextHolder = interface(IUnknown)
    ['{6960289E-78CF-4976-9E0D-6A654282DDAD}']
    function Get_EditText(out pVal: WideString): HResult; stdcall;
    function Set_EditText(const pVal: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IGrymControlComboBox
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {61D4F18D-90F5-4506-ADA6-DF4423F76B3C}
// *********************************************************************//
  IGrymControlComboBox = interface(IUnknown)
    ['{61D4F18D-90F5-4506-ADA6-DF4423F76B3C}']
    function ResetContent: HResult; stdcall;
    function AddString(const sVal: WideString; varData: OleVariant; out pIndex: Integer): HResult; stdcall;
    function InsertString(const sVal: WideString; nIndex: Integer; varData: OleVariant; 
                          out pIndex: Integer): HResult; stdcall;
    function GetString(nIndex: Integer; out pVal: WideString): HResult; stdcall;
    function GetData(nIndex: Integer; out pVal: OleVariant): HResult; stdcall;
    function DeleteString(nIndex: Integer): HResult; stdcall;
    function FindStringExact(nStartIndex: Integer; const sVal: WideString; out pIndex: Integer): HResult; stdcall;
    function FindString(nStartIndex: Integer; const sVal: WideString; out pIndex: Integer): HResult; stdcall;
    function Get_Count(out pVal: Integer): HResult; stdcall;
    function Set_ComboBoxStyle(pVal: ComboBoxStyle): HResult; stdcall;
    function Get_ComboBoxStyle(out pVal: ComboBoxStyle): HResult; stdcall;
    function Set_DropDownWidth(pVal: Integer): HResult; stdcall;
    function Get_DropDownWidth(out pVal: Integer): HResult; stdcall;
    function Set_CurSel(pVal: Integer): HResult; stdcall;
    function Get_CurSel(out pVal: Integer): HResult; stdcall;
    function Set_TopIndex(pVal: Integer): HResult; stdcall;
    function Get_TopIndex(out pVal: Integer): HResult; stdcall;
    function DropDown(out bSuccess: WordBool): HResult; stdcall;
    function CloseUp(out bSuccess: WordBool): HResult; stdcall;
    function Get_DroppedDown(out pVal: WordBool): HResult; stdcall;
    function Get_DropDownCount(out pVal: Integer): HResult; stdcall;
    function Set_DropDownCount(pVal: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IGrymControlEdit
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {6F37C3D9-BFD1-4E0E-9DCA-1DDF0373C76B}
// *********************************************************************//
  IGrymControlEdit = interface(IUnknown)
    ['{6F37C3D9-BFD1-4E0E-9DCA-1DDF0373C76B}']
    function Get_ReadOnly(out pVal: WordBool): HResult; stdcall;
    function Set_ReadOnly(pVal: WordBool): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IListBoxItemDrawInfo
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {C4B32C93-CE9D-40C9-A2DF-E96571B16FCA}
// *********************************************************************//
  IListBoxItemDrawInfo = interface(IUnknown)
    ['{C4B32C93-CE9D-40C9-A2DF-E96571B16FCA}']
    function Get_ItemAction(out pVal: Integer): HResult; stdcall;
    function Get_ItemState(out pVal: Integer): HResult; stdcall;
    function Get_WindowHandle(out pVal: OLE_HANDLE): HResult; stdcall;
    function Get_WindowDC(out pVal: OLE_HANDLE): HResult; stdcall;
    function Get_ItemRect(out pVal: IDevRect): HResult; stdcall;
    function Get_ItemData(out pVal: OleVariant): HResult; stdcall;
    function Get_ItemID(out pVal: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IEditAreaDrawInfo
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {3A2A65AE-6292-4AA3-B320-8CC89B416734}
// *********************************************************************//
  IEditAreaDrawInfo = interface(IUnknown)
    ['{3A2A65AE-6292-4AA3-B320-8CC89B416734}']
    function Get_WindowDC(out pVal: OLE_HANDLE): HResult; stdcall;
    function Get_ItemRect(out pVal: IDevRect): HResult; stdcall;
    function Get_CurSel(out pVal: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IListBoxItemDrawer
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {5F10FA9A-D29A-489B-B97E-A1E8166B386D}
// *********************************************************************//
  IListBoxItemDrawer = interface(IUnknown)
    ['{5F10FA9A-D29A-489B-B97E-A1E8166B386D}']
    function DrawItem(const pVal: IListBoxItemDrawInfo): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IEditAreaDrawer
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {B8E0C3B2-C086-42A5-BCF2-092BE63CB775}
// *********************************************************************//
  IEditAreaDrawer = interface(IUnknown)
    ['{B8E0C3B2-C086-42A5-BCF2-092BE63CB775}']
    function DrawEditArea(const pVal: IEditAreaDrawInfo): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ICustomDrawGrymControlComboBox
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {FDCC30BA-7042-4994-92CB-22CF5B13B3A2}
// *********************************************************************//
  ICustomDrawGrymControlComboBox = interface(IUnknown)
    ['{FDCC30BA-7042-4994-92CB-22CF5B13B3A2}']
    function SetListBoxItemDrawer(const pVal: IListBoxItemDrawer): HResult; stdcall;
    function SetEditAreaDrawer(const pVal: IEditAreaDrawer): HResult; stdcall;
    function Get_ItemHeight(out pVal: Integer): HResult; stdcall;
    function Set_ItemHeight(pVal: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IStatusFeedback
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {0BE8D8AA-8E67-4D54-BDE2-E81D2214A6B9}
// *********************************************************************//
  IStatusFeedback = interface(IUnknown)
    ['{0BE8D8AA-8E67-4D54-BDE2-E81D2214A6B9}']
    function Get_Done(out pVal: WordBool): HResult; stdcall;
    function Set_Done(pVal: WordBool): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  _IGrymControlEditEvents
// Flags:     (4096) Dispatchable
// GUID:      {5CE773A6-9501-4ECB-B98E-66E9D70E0085}
// *********************************************************************//
  _IGrymControlEditEvents = dispinterface
    ['{5CE773A6-9501-4ECB-B98E-66E9D70E0085}']
    procedure OnEditChanged; dispid 1;
    procedure OnKeyDown(nChar: Integer; const pHandled: IStatusFeedback); dispid 2;
  end;

// *********************************************************************//
// DispIntf:  _IGrymControlComboBoxEvents
// Flags:     (4096) Dispatchable
// GUID:      {B80D4D83-8141-43A6-9DEC-9D0AC0777583}
// *********************************************************************//
  _IGrymControlComboBoxEvents = dispinterface
    ['{B80D4D83-8141-43A6-9DEC-9D0AC0777583}']
    procedure OnEditChanged; dispid 1;
    procedure OnSelChanged; dispid 2;
    procedure OnDropDown; dispid 3;
    procedure OnCloseUp; dispid 4;
    procedure OnKeyDown(nChar: Integer; const pHandled: IStatusFeedback); dispid 5;
  end;

// *********************************************************************//
// DispIntf:  _IGrymControlAutoSuggestionComboBoxEvents
// Flags:     (4096) Dispatchable
// GUID:      {44B559CF-9019-42D9-BD8C-7F163CD0A4B5}
// *********************************************************************//
  _IGrymControlAutoSuggestionComboBoxEvents = dispinterface
    ['{44B559CF-9019-42D9-BD8C-7F163CD0A4B5}']
    procedure OnSelChanged(varItemData: OleVariant); dispid 1;
    procedure OnKeyDown(nChar: Integer; const pHandled: IStatusFeedback); dispid 2;
    procedure OnEditChanged; dispid 3;
  end;

// *********************************************************************//
// DispIntf:  _IBaseViewFrameEvents
// Flags:     (4096) Dispatchable
// GUID:      {7C158590-5DAF-48D6-BC86-B267F5E8935B}
// *********************************************************************//
  _IBaseViewFrameEvents = dispinterface
    ['{7C158590-5DAF-48D6-BC86-B267F5E8935B}']
    procedure OnActivate; dispid 1;
    procedure OnDeactivate; dispid 2;
    procedure OnBeforeViewModeChange(nNewViewMode: BaseFrameViewMode); dispid 3;
    procedure OnAfterViewModeChange(nNewViewMode: BaseFrameViewMode); dispid 4;
  end;

// *********************************************************************//
// DispIntf:  _IGrymHTMLViewControlEvents
// Flags:     (4096) Dispatchable
// GUID:      {667F2E2B-7DD9-4E89-9AB5-6B095C0EC170}
// *********************************************************************//
  _IGrymHTMLViewControlEvents = dispinterface
    ['{667F2E2B-7DD9-4E89-9AB5-6B095C0EC170}']
    procedure OnLink(const bsLink: WideString); dispid 1;
    procedure OnButton(const bsElementID: WideString); dispid 2;
    procedure OnLeftMouseButtonClick(const pActionPoint: IDevPoint; const bsElementID: WideString); dispid 3;
    procedure OnRightMouseButtonClick(const pActionPoint: IDevPoint; const bsElementID: WideString); dispid 4;
    procedure OnHitTest(const ptVal: IDevPoint; const bsElementID: WideString; 
                        const pHitTestFill: IHitTestFill); dispid 5;
  end;

// *********************************************************************//
// Interface: IGrymAuthData
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {58601E2C-AC6F-4B56-8E04-DFAD70F4FD39}
// *********************************************************************//
  IGrymAuthData = interface(IUnknown)
    ['{58601E2C-AC6F-4B56-8E04-DFAD70F4FD39}']
    function Get_Login(out pVal: WideString): HResult; stdcall;
    function Get_Password(out pVal: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IGrymProxyOptions
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {B8B128C8-8D17-41EF-9C2A-65C5A319E999}
// *********************************************************************//
  IGrymProxyOptions = interface(IUnknown)
    ['{B8B128C8-8D17-41EF-9C2A-65C5A319E999}']
    function Get_UseProxy(out pVal: WordBool): HResult; stdcall;
    function Get_ProxyAddr(out pVal: WideString): HResult; stdcall;
    function Get_ProxyPort(out pVal: Integer): HResult; stdcall;
    function Get_AuthType(out pVal: ProxyAuthType): HResult; stdcall;
    function RequestProxyAuthData(bForceShowDlg: WordBool; const bsAdditionalMessage: WideString; 
                                  out pVal: IGrymAuthData): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IGrymConnectionOptionsCallback
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {59418AFA-A778-41E6-A264-BC7495378AC0}
// *********************************************************************//
  IGrymConnectionOptionsCallback = interface(IUnknown)
    ['{59418AFA-A778-41E6-A264-BC7495378AC0}']
    function OnProxyOptionsReady(const pVal: IGrymProxyOptions): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IGrymConnectionOptions
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {F6427B21-5061-4030-8AF5-C1AF84204FD0}
// *********************************************************************//
  IGrymConnectionOptions = interface(IUnknown)
    ['{F6427B21-5061-4030-8AF5-C1AF84204FD0}']
    function RequestProxyOptions(const bsAddress: WideString; const bsProtocol: WideString; 
                                 const pCallback: IGrymConnectionOptionsCallback): HResult; stdcall;
  end;

// *********************************************************************//
// The Class CoBaseCollection provides a Create and CreateRemote method to          
// create instances of the default interface IBaseCollection exposed by              
// the CoClass BaseCollection. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoBaseCollection = class
    class function Create: IBaseCollection;
    class function CreateRemote(const MachineName: string): IBaseCollection;
  end;

// *********************************************************************//
// The Class CoGrym provides a Create and CreateRemote method to          
// create instances of the default interface IGrym exposed by              
// the CoClass Grym. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoGrym = class
    class function Create: IGrym;
    class function CreateRemote(const MachineName: string): IGrym;
  end;

// *********************************************************************//
// The Class CoCallout provides a Create and CreateRemote method to          
// create instances of the default interface ICallout exposed by              
// the CoClass Callout. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCallout = class
    class function Create: ICallout;
    class function CreateRemote(const MachineName: string): ICallout;
  end;

// *********************************************************************//
// The Class CoCalloutTab provides a Create and CreateRemote method to          
// create instances of the default interface ICalloutTab exposed by              
// the CoClass CalloutTab. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCalloutTab = class
    class function Create: ICalloutTab;
    class function CreateRemote(const MachineName: string): ICalloutTab;
  end;

// *********************************************************************//
// The Class CoBaseViewFrame provides a Create and CreateRemote method to          
// create instances of the default interface IBaseViewFrame exposed by              
// the CoClass BaseViewFrame. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoBaseViewFrame = class
    class function Create: IBaseViewFrame;
    class function CreateRemote(const MachineName: string): IBaseViewFrame;
  end;

// *********************************************************************//
// The Class CoGrymControlComboBox provides a Create and CreateRemote method to          
// create instances of the default interface IGrymControlComboBox exposed by              
// the CoClass GrymControlComboBox. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoGrymControlComboBox = class
    class function Create: IGrymControlComboBox;
    class function CreateRemote(const MachineName: string): IGrymControlComboBox;
  end;

// *********************************************************************//
// The Class CoGrymControlEdit provides a Create and CreateRemote method to          
// create instances of the default interface IGrymControlEdit exposed by              
// the CoClass GrymControlEdit. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoGrymControlEdit = class
    class function Create: IGrymControlEdit;
    class function CreateRemote(const MachineName: string): IGrymControlEdit;
  end;

// *********************************************************************//
// The Class CoGrymHTMLViewControl provides a Create and CreateRemote method to          
// create instances of the default interface IGrymHTMLViewControl exposed by              
// the CoClass GrymHTMLViewControl. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoGrymHTMLViewControl = class
    class function Create: IGrymHTMLViewControl;
    class function CreateRemote(const MachineName: string): IGrymHTMLViewControl;
  end;

// *********************************************************************//
// The Class CoGrymControlAutoSuggestionComboBox provides a Create and CreateRemote method to          
// create instances of the default interface IGrymControlAutoSuggestionComboBox exposed by              
// the CoClass GrymControlAutoSuggestionComboBox. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoGrymControlAutoSuggestionComboBox = class
    class function Create: IGrymControlAutoSuggestionComboBox;
    class function CreateRemote(const MachineName: string): IGrymControlAutoSuggestionComboBox;
  end;

implementation

uses ComObj;

class function CoBaseCollection.Create: IBaseCollection;
begin
  Result := CreateComObject(CLASS_BaseCollection) as IBaseCollection;
end;

class function CoBaseCollection.CreateRemote(const MachineName: string): IBaseCollection;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_BaseCollection) as IBaseCollection;
end;

class function CoGrym.Create: IGrym;
begin
  Result := CreateComObject(CLASS_Grym) as IGrym;
end;

class function CoGrym.CreateRemote(const MachineName: string): IGrym;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Grym) as IGrym;
end;

class function CoCallout.Create: ICallout;
begin
  Result := CreateComObject(CLASS_Callout) as ICallout;
end;

class function CoCallout.CreateRemote(const MachineName: string): ICallout;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Callout) as ICallout;
end;

class function CoCalloutTab.Create: ICalloutTab;
begin
  Result := CreateComObject(CLASS_CalloutTab) as ICalloutTab;
end;

class function CoCalloutTab.CreateRemote(const MachineName: string): ICalloutTab;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CalloutTab) as ICalloutTab;
end;

class function CoBaseViewFrame.Create: IBaseViewFrame;
begin
  Result := CreateComObject(CLASS_BaseViewFrame) as IBaseViewFrame;
end;

class function CoBaseViewFrame.CreateRemote(const MachineName: string): IBaseViewFrame;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_BaseViewFrame) as IBaseViewFrame;
end;

class function CoGrymControlComboBox.Create: IGrymControlComboBox;
begin
  Result := CreateComObject(CLASS_GrymControlComboBox) as IGrymControlComboBox;
end;

class function CoGrymControlComboBox.CreateRemote(const MachineName: string): IGrymControlComboBox;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_GrymControlComboBox) as IGrymControlComboBox;
end;

class function CoGrymControlEdit.Create: IGrymControlEdit;
begin
  Result := CreateComObject(CLASS_GrymControlEdit) as IGrymControlEdit;
end;

class function CoGrymControlEdit.CreateRemote(const MachineName: string): IGrymControlEdit;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_GrymControlEdit) as IGrymControlEdit;
end;

class function CoGrymHTMLViewControl.Create: IGrymHTMLViewControl;
begin
  Result := CreateComObject(CLASS_GrymHTMLViewControl) as IGrymHTMLViewControl;
end;

class function CoGrymHTMLViewControl.CreateRemote(const MachineName: string): IGrymHTMLViewControl;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_GrymHTMLViewControl) as IGrymHTMLViewControl;
end;

class function CoGrymControlAutoSuggestionComboBox.Create: IGrymControlAutoSuggestionComboBox;
begin
  Result := CreateComObject(CLASS_GrymControlAutoSuggestionComboBox) as IGrymControlAutoSuggestionComboBox;
end;

class function CoGrymControlAutoSuggestionComboBox.CreateRemote(const MachineName: string): IGrymControlAutoSuggestionComboBox;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_GrymControlAutoSuggestionComboBox) as IGrymControlAutoSuggestionComboBox;
end;

end.
