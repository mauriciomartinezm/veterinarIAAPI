import {Router} from 'express';
import {
    getCita,
    getCitas,
    getHorarios,
    registerCita,
    updateHorario,
    deleteCita,
} from '../controllers/CitaController.js';

const router = Router ();

router.get('/getCita/:IDCita', getCita);
router.get('/getHorarios', getHorarios);
router.get('/getCitas/:Propietario', getCitas);
router.post('/registerCita', registerCita);
router.put('/updateHorario/:IDHorario', updateHorario);
router.delete('/deleteCita/:IDCita', deleteCita);
export default router;