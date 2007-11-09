module WymEditorHelper
  # creates a text_area for the given object/field pair
  # and keeps track of the ID used (necessary for wym_editor_initialize)
  def wym_editor(object, field, options={})
    editor_id = options[:id] || '%s_%s' % [object, field]
    mode      = options.delete(:simple) ? 'simple' : 'extended'
    (@wym_editor_ids ||= []) << [editor_id, mode]
    options[:class] = "wymeditor"
    text_area(object, field, options)
  end
  
  # adds the necessary javascript include tags, stylesheet tags,
  # and load event with necessary javascript to activate wym editor(s)

  def wym_editor_initialize(*dom_ids)
    editor_ids = (@wym_editor_ids || []) + wym_extract_dom_ids(*dom_ids)
    output = []
    output << stylesheet_link_tag('/wymeditor/wymeditor/skins/default/screen')
    output << javascript_include_tag('/wymeditor/jquery/jquery')
    output << javascript_include_tag('/wymeditor/wymeditor/lang/en.js')
    output << javascript_include_tag('/wymeditor/wymeditor/jquery.wymeditor.js')
    output << javascript_include_tag('/wymeditor/wymeditor/jquery.wymeditor.explorer.js')
    output << javascript_include_tag('/wymeditor/wymeditor/jquery.wymeditor.mozilla.js')
    output << javascript_include_tag('/wymeditor/wymeditor/jquery.wymeditor.opera.js')
    output << javascript_include_tag('/wymeditor/wymeditor/jquery.wymeditor.safari.js')
    output << javascript_include_tag('/javascripts/boot_wym.js')
    output.join("\n")
  end
  
  def wym_extract_dom_ids(*dom_ids)
    hash = dom_ids.last.is_a?(Hash) ? dom_ids.pop : {}

    hash.inject(dom_ids) do |ids, (object, fields)|
      ids + Array(fields).map { |field| "%s_%s" % [object, field] }
    end
  end
end