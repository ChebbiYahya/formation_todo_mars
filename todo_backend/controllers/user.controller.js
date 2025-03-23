const UserService = require('../services/user.service.js');

exports.register = async(req,res,next)=>{
    try {
        const {nom,email,password}=req.body;

        const successRes = await UserService.registerUser(nom,email,password);

        res.json({status:true,success:"User Registered Successfully"});

    } catch (error) {
        next(error) ;
        
    }
}

exports.login = async (req,res,next)=>{
    try {
        const{email,password}=req.body;
        const user =await UserService.checkuser(email);
        if(!user){
            throw new Error('User dont exist');
        }
        const isMatch =await user.comparePassword(password);
        if(isMatch==false){
            throw new Error('Passwod Invalid');
        }
        let tokenData = {_id:user._id,email:user.email}
        const token = await UserService.generateToken(tokenData,"secretKey",'1h');
        res.status(200).json({status:true,token:token});
    } catch (error) {
        next(error) ;
    }
}