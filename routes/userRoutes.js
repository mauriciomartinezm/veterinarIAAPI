import {Router} from 'express';
import {
    getUsers,
    getUser,
    registerUser,
    updateUser,
    loginUser
} from '../controllers/userController.js';

const router = Router ();

router.get('/getUser/:CedulaPropietario', getUser);
router.get('/getUsers', getUsers);
router.post('/registerUser', registerUser);
router.put('/updateUser/:cedula', updateUser );
router.put('/user/:id', updateUser);
router.post('/login', loginUser);

export default router;