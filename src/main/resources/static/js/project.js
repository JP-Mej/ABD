const API = "http://localhost:8080/api/project";

// ✅ LISTAR PROYECTOS
function listarProyectos() {
    fetch(API)
        .then(res => res.json())
        .then(data => {
            let tabla = "";
            data.forEach(p => {
                tabla += `
                    <tr>
                        <td>${p.projectId}</td>
                        <td>${p.nameP}</td>
                        <td>${p.budgetAmount}</td>
                        <td>${p.status}</td>
                    </tr>
                `;
            });
            const tbody = document.getElementById("tablaProyectos");
            if (tbody) tbody.innerHTML = tabla;
        })
        .catch(err => console.error("Error al listar proyectos:", err));
}

// ✅ GUARDAR PROYECTO
function guardarProyecto() {
    const proyecto = {
        projectId: Number(document.getElementById("projectId").value),
        activityId: Number(document.getElementById("activityId").value),
        fundingId: Number(document.getElementById("fundingId").value),
        indicatorId: Number(document.getElementById("indicatorId").value),
        locationId: Number(document.getElementById("locationId").value),
        nameP: document.getElementById("nameP").value,
        descriptionP: document.getElementById("descriptionP").value,
        budgetAmount: Number(document.getElementById("budgetAmount").value),
        strategicArea: document.getElementById("strategicArea").value,
        startDateP: document.getElementById("startDateP").value,
        endDateP: document.getElementById("endDateP").value,
        status: document.getElementById("status").value
    };

    fetch(API, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(proyecto)
    })
    .then(res => {
        if (!res.ok) throw new Error("Error al guardar proyecto");
        return res.json();
    })
    .then(() => {
        alert("Proyecto creado");
        listarProyectos();
    })
    .catch(err => console.error(err));
}

// ✅ CARGA AUTOMÁTICA
window.onload = listarProyectos;
