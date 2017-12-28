module FlashHelper
  def flash_messages
    render partial: 'layouts/flash_messages', flash: flash
  end
end