# -*- coding: utf-8 -*-
require "grape"
require "./app/controllers/password_controller"
require "./config/application"

Application.new

module Web

        class API < Grape::API
                content_type :json, "application/json"
                default_format :json

                resource :password do
                        desc "find password by url"
                        params do
                                requires :url, type: String
                                requires :key, type: String
                        end
                        post "find" do
                                PasswordController.new.find(params[:url], params[:key])
                        end


                        desc "create a random password for an url"
                        params do
                                requires :url, type: String
                                requires :enable_special, type: Boolean
                                requires :length, type: Integer
                                requires :key, type: String
                        end
                        post "random" do
                                PasswordController.new.random(params[:url], params[:enable_special], params[:length], params[:key])
                        end


                        desc "create a password for an url"
                        params do
                                requires :url, type: String
                                requires :plain, type: String
                                requires :comment, type: String
                                requires :key, type: String
                        end
                        post do
                                PasswordController.new.create(params[:url], params[:plain], params[:comment], params[:key])
                        end


                        desc "update data"
                        params do
                                requires :url, type: String
                                requires :plain, type: String
                                requires :comment, type: String
                                requires :key, type: String
                        end
                        put do
                                PasswordController.new.update(params[:url], params[:plain], params[:comment], params[:key])
                        end


                        desc "remove password by url"
                        params do
                                requires :url, type: String
                        end
                        delete do
                                PasswordController.new.destroy(params[:url])
                        end


                        desc "get all passwords"
                        get do
                                PasswordController.new.all
                        end
                end

                # rescue from errors
                # rescue_from :all do |e|
                #         Rack::Response.new([ "We have encounted some error!" ], 500, { "Content-type" => "text/error" }).finish
                # end

                # 404
                # route :any, '*path' do
                #         content_type :txt, "text/plain"
                #         body false # return nothing
                # end

        end
end
