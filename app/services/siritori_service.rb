# frozen_string_literal: true

class SiritoriService < BaseService
  def is_success?(text)
    prev_status = Status.where(is_siritori_success: true).order('id desc').first

    return true unless prev_status

    #FIXME 直近x件でかぶっていないかも確認
    
    text.first == prev_status.text.last
  end
end
