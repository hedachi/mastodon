# frozen_string_literal: true

class SiritoriService < BaseService
  def is_success?(text, account)
    prev_status = Status.where(is_siritori_success: true).order('id desc').first

    return true  unless prev_status

    return false if prev_status.account.id == account.id

    #FIXME 直近x件でかぶっていないかも確認
    
    text.first == prev_status.text.last
  end
end
