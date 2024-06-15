import { pool } from "../server.js";

export const getCita = async (req, res) => {
  console.log("Petición recibida en /getCita");
  console.log("Parámetros de la petición:", req.params);

  try {
    const [result] = await pool.query(
      "SELECT * FROM cita WHERE IDCita = ?",
      [req.params.IDCita]
    );

    if (result.length === 1) {
      console.log("Cita: ", result[0]);

      return res
        .status(200)
        .json({ messageSuccess: "Cita encontrada", pet: result[0] });
    }
  } catch (error) {
    return res.status(401).json({ unknown: "Error con la consulta" });
  }
};

export const getCitas = async (req, res) => { //si
  console.log("Petición recibida en /getCitas");
  console.log("Parámetros recibidos: ", req.params);
  try {
    const [result] = await pool.query(
      "SELECT * FROM cita where Propietario = ?",
      [req.params.Propietario]
    );
    res.json(result);
    console.log(result);
    return result;
  } catch (error) {
    return res
      .status(500)
      .json({ message: "Error interno del servidor", error: error.message });
  }
};
export const getHorarios = async (req, res) => { // si
  console.log("Petición recibida en /getHorarios");
  try {
    const [result] = await pool.query(
      "SELECT * FROM horario",
    );
    res.json(result);
    console.log(result);
    return result;
  } catch (error) {
    return res
      .status(500)
      .json({ message: "Error interno del servidor", error: error.message });
  }
};

export const updateHorario = async (req, res) => { //si
  console.log("Petición recibida en /updateHorario");
  console.log("Cuerpo recibidio: ", req.body);
  console.log("Parámetros recibidos: ", req.params);
  const { Estado } = req.body;

  try {
    const result = await pool.query("UPDATE horario SET estado = ? WHERE id = ?", [
      Estado,
      req.params.IDHorario,
    ]);
    console.log("Horario actualizado");
    res.status(200).json({ messageSuccess: "Horario actualizado correctamente" });
  } catch (error) {
    console.error("Error al actualizar el horario:", error);
    res.status(500).json({ message: error.message });
  }
};

export const registerCita = async (req, res) => { //si
  console.log("Petición recibida en /registerCita");
  console.log("Información recibida:", req.body);
  const { IDMascota, IDHorario, CedulaPropietario, Motivo } = req.body;
  try {
    const result = await pool.query(
      "INSERT INTO cita(IDMascota, IDHorario, Propietario, Observaciones) VALUES (?, ?, ?, ?)",
      [IDMascota, IDHorario, CedulaPropietario, Motivo]
    );
    const insertedId = await pool.query("SELECT LAST_INSERT_ID()");
    var idReturned = insertedId[0][0]["LAST_INSERT_ID()"];

    console.log("Registro exitoso");
    console.log("ID de la cita creada:", idReturned);
    return res
      .status(200)
      .json({ messageSuccess: "Registro exitoso", id: idReturned });
  } catch (error) {
    console.error("Error al crear usuario:", error);
    return res.status(500).json({ messageFail: error.message });
  }
};

export const deleteCita= async (req, res) => { //
  console.log("Petición recibida en /deleteCita");
  console.log("Parámetros recibidos: ", req.params);
  try {
    const result = await pool.query("DELETE FROM cita WHERE IDCita = ?", [
      req.params.IDCita,
    ]);

    console.log("Cita eliminada");
    res.status(200).json({ message: "Cita eliminada correctamente" });
  } catch (error) {
    console.error("Error al eliminar cita:", error);
    res
      .status(500)
      .json({ message: "Error interno del servidor", error: error.message });
  }
};
