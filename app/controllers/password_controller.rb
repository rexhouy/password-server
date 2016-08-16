require "./app/models/password"
require 'securerandom'
require "json"

class PasswordController

        def find(url, key)
                password = Password.find_by_url(url)
                return password.serialize(key) unless password.nil?
                {}
        end

        def random(url, enable_special, length, key)
                password = Password.find_by_url(url)
                return password.serialize(key) unless password.nil?
                password = Password.new
                password.url = url
                password.set_encrypted(random_password(enable_special, length), key)
                password.save! ? password.serialize(key) : {}
        end

        def create(url, plain, comment, key)
                password = Password.new
                password.url = url
                password.set_encrypted(plain, key)
                password.comment = comment
                password.save! ? password.serialize(key) : {}
        end

        def update(url, plain, comment, key)
                password = Password.find_by_url(url)
                return password.serialize(key) if password.nil?
                password.set_encrypted(plain, key)
                password.comment = comment
                password.save! ? password.serialize(key) : {}
        end

        def destroy(url)
                password = Password.find_by_url(url)
                password.destroy!
                {}
        end

        def all
                Password.all.map do |password|
                        password.serialize
                end
        end

        def encrypted
                Password.all.map do |password|

                end
        end

        private
        def random_password(enable_special, length)
                enable_special ? SecureRandom.base64(length) : SecureRandom.hex(length/2)
        end

end
