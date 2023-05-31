# Galendae

Calendario emergente para i3, con colores propios.
Se abre con clic derecho en la barra.

## Instalación

1. Instalar las dependencias de compilación.

   ```bash
   sudo dnf install gtk3-devel gcc make git
   ```

2. Clonar y compilar.

   ```bash
   git clone --depth 1 https://github.com/chris-marsh/galendae.git /tmp/galendae
   cd /tmp/galendae
   make release
   ```

3. Instalar el binario.

   ```bash
   install -Dm 755 galendae ~/.local/bin/galendae
   ```

4. Enlazar la configuración, el tema y la fuente.

   ```bash
   mkdir -p ~/.config/galendae ~/.config/gtk-3.0
   ln -s ~/gitrepo/dotfiles/config/app/galendae/galendae.conf ~/.config/galendae/galendae.conf
   ln -s ~/gitrepo/dotfiles/config/app/galendae/gtk.css ~/.config/gtk-3.0/gtk.css
   ```

5. Reiniciar i3 con `Super+Shift+r`.
   La barra ya trae el clic derecho y el icono, en `config/app/i3/config` y `config/app/i3status/config`.

## Uso

- Clic derecho en la barra: abre el calendario junto al puntero.
- Abrirlo otra vez con el calendario visible lo cierra.
- `q` o `Esc` cierran el calendario.
- `h` y `l` cambian de mes, `j` y `k` cambian de año, `g` vuelve a hoy.

## Notas

- Los colores y el primer día de la semana se cambian en `galendae.conf`.
- Galendae no tiene opción de fuente, así que `gtk.css` la fija con una regla que solo afecta a su ventana.
- `gtk.css` es la hoja de estilo global de GTK3, y si ya tienes una hay que unir las reglas.
- El binario no está en el repo, por eso hay que compilarlo en cada máquina.
- `~/.local/bin` tiene que estar en el `PATH`, o el clic derecho no lo encuentra.
