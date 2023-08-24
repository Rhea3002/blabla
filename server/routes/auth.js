const express = require("express");         //js package for easy server setup
const User = require("../models/user.js");
const bcryptjs = require('bcryptjs');   //for hashing the password of the user.
const jwt = require('jsonwebtoken');    //ensure genuine users, rather than hackers.

const authRouter = express.Router();

const auth = require("../middleware/auth");

//SIGN UP route
authRouter.post("/api/signup", async function (req, res) {
    try{
        //get data from user
        const { type, name, email, password, address } = req.body;

        const existingUser = await User.findOne({ email }); 
        //.findOne is a promise(a good way to handle asynchronous operations) 
        // that will disallow users from creating 2 accounts from same email ID
        if(existingUser){
            return res.status(400).json({ msg: "User with same email ID already exists"});
            //400: Bad Request : The server cannot or will not process the request due to something that is perceived to be a 
            //CLIENT ERROR (e.g., malformed request syntax, invalid request message framing, or deceptive request routing).
        }

        const hashedPwd = await bcryptjs.hash(password, 8); //here, 8 is a salt 
        //So 2 same string passwords won't have same hashed values because of the salt.

        let user = new User({
            type,
            name,
            email,
            address,
            password: hashedPwd,
        })

        user = await user.save();
        res.json(user);     //send the user data to the json file
        //post that data in database

    }catch(e){
        res.status(500).json({error: e.message});
        //500: Internal Server error : the server has encountered a situation it does not know how to handle.
    }

})

//SignIn Route 
//To do this, we install jsonWebtoken(jwt). This will be useful to authenticate the user. 
authRouter.post("/api/signin", async function (req, res){
    try{
        const {email, password} = req.body; //extract from singup

        const user = await User.findOne({ email });

        //(!abc): called as guard clauses. instead of using nested if else condition, a neater format.
        if(!user){      //if user not found            
            return res.status(400).json({ msg: "User with same email ID does not exists"}); //CLIENT SIDE ERROR
        }

        const isMatched = await bcryptjs.compare(password, user.password);      //match the hash value of the password entered

        if(!isMatched){
            return res.status(400).json({ msg: "Incorrect Password Entered."})
        }

        const token = jwt.sign({ id: user._id }, "passwordKey");    
        //passwordKey: PrivateKey stored in device memory and sent to server
        res.json({token, ...user._doc})
    }
    catch(e){
        res.status(500).json({error: e.message});
    }
})

authRouter.post("/tokenIsValid", async function (req, res){
    try{
        const token = req.header('x-auth-token');   //search for token
        if(!token) return res.json(false);      //if token not found, return false.

        const verified = jwt.verify(token, 'passwordKey');       //if token found, verify using jwt.

        if(!verified) return res.json(false);   //if not verified, return false

        const user = await User.findById(verified.id); //if successful check if user exists or not. id same as user._id

        if(!user) return res.json(false);   //if user does not exists, return false.

        res.json(true);         //else verification complete. Hence true
    }
    catch(e){
        res.status(500).json({error: e.message});
    }
})

//get user data
authRouter.get('/', auth, async (req, res) => {         
    const user = await User.findById(req.user);
    res.json({ ...user._doc, token: req.token });
})

module.exports = authRouter; //express package command for authentication