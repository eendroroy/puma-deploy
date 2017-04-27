def smart_template(from, to = nil)
  to ||= from
  full_to_path = "#{shared_path}/config/#{to}"
  if (from_erb_path = template_file(from))
    from_erb = StringIO.new(ERB.new(File.read(from_erb_path)).result(binding))
    upload! from_erb, full_to_path
    info "copying: #{from_erb} to: #{full_to_path}"
  else
    error "error #{from} not found"
  end
end

def template_file(name)
  file = "config/deploy/#{fetch(:full_app_name)}/#{name}.erb"
  return file if File.exist?(file)
  file = "config/deploy/shared/#{name}.erb"
  return file if File.exist?(file)
  nil
end
