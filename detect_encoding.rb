require 'charlock_holmes'
require 'gpgme'

module DetectEncoding
  def self.run(data)
    CharlockHolmes::EncodingDetector.detect data
  end

  def self.run_gpg_file(file_path)
    ctx = GPGME::Ctx.new passphrase_callback: :passfunc
    ctx.import_keys GPGME::Data.new(File.open("#{ENV['HOME']}/sftp_key/sftp_private.key"))
    decrypted = ctx.decrypt GPGME::Data.new(File.open(file_path))
    decrypted.seek 0
    run decrypted.read
  end
end
