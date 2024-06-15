import {Router} from 'express';
import {
    getPet,
    getPets,
    registerPet,
    updatePet,
    deletePet,
} from '../controllers/petController.js';

const router = Router ();

router.get('/getPet/:IDMascota', getPet);
router.get('/getPets/:cedulaPropietario', getPets);
router.post('/registerPet', registerPet);
router.put('/updatePet/:IDMascota', updatePet);
router.delete('/deletePet/:IDMascota', deletePet);
export default router;