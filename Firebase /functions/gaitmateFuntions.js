const admin = require('firebase-admin');
const db = admin.firestore();
const functions = require('firebase-functions');

exports.userIdVerification = functions.https.onRequest((req, res) => {
    db.collection('ValidIds').doc('users').get().then((users)=>{
        if (req.query.userId){
            let userId = req.query.userId
            if (users.exists) {
                let data = users.data()
                if (data['ids']) {
                    let ids = data['ids'] 
                    if (ids.includes(userId)){
                        res.status(201).send(true)
                        return
                    }
                }
            }
        }
        res.status(403).send(false)
    })
});