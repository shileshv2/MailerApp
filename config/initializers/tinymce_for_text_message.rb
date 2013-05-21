# Be sure to restart your server when you modify this file.

Tinymce::Hammer.install_path='/javascripts/tiny_mce'

Tinymce::Hammer.init=[
  [:theme, 'advanced'],
  [:theme_advanced_toolbar_align, 'left'],
  [:theme_advanced_toolbar_location, 'top'],
  [:theme_advanced_buttons1, 'undo,redo,|,bold,italic,underline,strikethrough,|,forecolor,formatselect,fontselect,fontsizeselect,|,code,preview'],
  [:theme_advanced_buttons2, 'spellchecker,|,cut,copy,paste,pastetext,pasteword,|,justifyleft,justifycenter,justifyright,justifyfull,|,bullist,numlist,outdent,indent,|,link,unlink,|,image,hr,charmap'],
  [:theme_advanced_buttons3, 'fullscreen,|,blockquote,anchor,tablecontrols,|,removeformat,visualaid,sub,sup,cleanup'],
  [:invalid_elements, "script"],
  [:external_image_list_url, "/marketing/engine/campaigns/images.js"],
  [:spellchecker_rpc_url, "/spellcheck"],
  [:spellchecker_languages, "+English=en"],
  [:elements, "tinymce_editor"],
  [:script_url, '/javascripts/jquery.tiny_mce.js'],
  [:pdw_toggle_on, '1'],
  [:pdw_toggle_toolbars, '2,3,4'],
  [:height, '300px'],
  [:width, '100%'],
  [:relative_urls, false]
]


Tinymce::Hammer.plugins=[
  'paste',
  'insertdatetime',
  'searchreplace',
  'spellchecker',
  'table',
  'fullscreen'
]

Tinymce::Hammer.setup="function(ed) {ed.onInit.add(function(ed) {try{tinymce_ready();} catch(e){}});}"
