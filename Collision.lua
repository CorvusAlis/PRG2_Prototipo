--clase para manejo de colisiones entre dos objetos cualquiera que tengan ancho y alto
--se fija si el objeto a se superpone por alguno de los bordes del objeto b

function checkAABB(a, b)

    return a.x < b.x + b.width
       and a.x + a.width > b.x
       and a.y < b.y + b.height
       and a.y + a.height > b.y

end

return checkAABB