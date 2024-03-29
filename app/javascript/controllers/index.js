// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import HelloController from "./hello_controller"
import LoginController from "./login_controller"
import UserController from "./user_controller"
import TeamController from "./team_controller"
import RoleController from "./role_controller"
import ProfileControler from "./profile_controller"
application.register("hello", HelloController)
application.register("login", LoginController)
application.register("user", UserController)
application.register("team", TeamController)
application.register("role", RoleController)
application.register("profile", ProfileControler)
