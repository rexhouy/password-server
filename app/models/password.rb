require 'rubygems'
require 'active_record'

##
# url
# encrypted
# iv
# salt
# comment
##
class Password < ActiveRecord::Base

        def serialize(key = nil)
                return {url: self.url, plain: "", comment: self.comment, encrypted: Base64.encode64(self.encrypted)} if key.nil?
                begin
                        {
                                url: self.url,
                                comment: self.comment,
                                plain: decrypt(self.encrypted, key)
                        }
                rescue
                        {url: self.url, plain: "", comment: ""}
                end
        end

        def set_encrypted(plain, key)
                self.encrypted = encrypt(plain, key)
        end

        private
        def encrypt(plain, key)
                cipher = OpenSSL::Cipher::AES.new(256, :CBC)
                cipher.encrypt
                self.salt = random_salt
                cipher.key = encrypt_key(key, self.salt)
                self.iv = cipher.random_iv
                cipher.update(plain) + cipher.final
        end

        def decrypt(encrypted, key)
                decipher = OpenSSL::Cipher::AES.new(256, :CBC)
                decipher.decrypt
                decipher.key = encrypt_key(key, self.salt)
                decipher.iv = self.iv
                decipher.update(encrypted) + decipher.final
        end

        def encrypt_key(key, salt)
                OpenSSL::PKCS5.pbkdf2_hmac_sha1(key, salt, 20000, 128)
        end

        def random_salt
                OpenSSL::Random.random_bytes(16)
        end
end
