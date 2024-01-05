module ControllerUtils
  extend ActiveSupport::Concern
  
  private

  def klass
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def params_list
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def find_record
    @record = klass.find(permitted_params[:id])
  end

  def init_errors
    @errors = []
  end

  def permitted_params
    params.permit params_list
  end
end