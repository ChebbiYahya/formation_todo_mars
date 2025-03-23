const UserModel = require('../models/user.model.js');
const jwt=require('jsonwebtoken');

class UserService{
    static async registerUser(nom,email, password){
        try {
            const createUser = new UserModel({nom,email,password});
            return await createUser.save();
        } catch (error) {
            next(error) ;
        }
    }

    static async checkuser(email){
        try {
            return await UserModel.findOne({email});
        } catch (error) {
            next(error) ;
        }
    }
    static async generateToken(tokenData,secretKey,jwt_expire){
        return jwt.sign(tokenData,secretKey,{expiresIn:jwt_expire});
    }
}
module.exports = UserService; 
