<% if namespaced? -%>
require_dependency "<%= namespaced_file_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  respond_to :html

  load_and_authorize_resource

  def index
    @<%= plural_table_name %> = @<%= plural_table_name %>.all
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    flash[:notice] = t 'was.created' if @<%= singular_table_name %>.save
    respond_with(@<%= singular_table_name %>)
  end

  def update
    flash[:notice] = t 'was.updated' if @<%= singular_table_name %>.update_attributes(params[:<%= singular_table_name %>])
    respond_with(@<%= singular_table_name %>)
  end

  def destroy
    @<%= singular_table_name %>.destroy
    flash[:notice] = t 'was.destroyed'
    respond_with(@<%= singular_table_name %>)
  end
end
<% end -%>
