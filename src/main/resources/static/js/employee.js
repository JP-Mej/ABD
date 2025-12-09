const API = "http://localhost:8080/api/employee";

// ✅ LISTAR EMPLEADOS
function listar() {
    fetch(API)
        .then(res => res.json())
        .then(data => {
            let tabla = "";
            data.forEach(e => {
                tabla += `
                    <tr>
                        <td>${e.employeeId}</td>
                        <td>${e.firstNameE}</td>
                        <td>${e.lastNameE}</td>
                        <td>${e.emailE}</td>
                        <td>${e.employmentType}</td>
                        <td>${e.salary}</td>
                        <td>
                            <button onclick="eliminar(${e.employeeId})">❌</button>
                        </td>
                    </tr>
                `;
            });
            document.getElementById("tablaEmpleados").innerHTML = tabla;
        });
}

// ✅ CREAR EMPLEADO (POST)
function guardarEmpleado() {
    const emp = {
        employeeId: document.getElementById("employeeId").value,
        firstNameE: document.getElementById("firstNameE").value,
        lastNameE: document.getElementById("lastNameE").value,
        birthDateE: document.getElementById("birthDateE").value,
        emailE: document.getElementById("emailE").value,
        phoneE: document.getElementById("phoneE").value,
        addressE: document.getElementById("addressE").value,
        employmentType: document.getElementById("employmentType").value,
        salary: document.getElementById("salary").value,
        startDateE: document.getElementById("startDateE").value,
        endDateE: document.getElementById("endDateE").value || null
    };

    fetch(API, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(emp)
    })
    .then(res => res.json())
    .then(() => {
        alert("✅ Empleado creado");
        listar();
    });
}

// ✅ ELIMINAR EMPLEADO (DELETE)
function eliminar(id) {
    fetch(`${API}/${id}`, {
        method: "DELETE"
    })
    .then(() => listar());
}

// ✅ PROMEDIO DE SALARIO
function promedioSalario() {
    fetch(`${API}/promedio-salario`)
        .then(res => res.json())
        .then(data => {
            alert("💰 Promedio salarial: " + data);
        });
}

// ✅ CARGA AUTOMÁTICA
window.onload = listar;
