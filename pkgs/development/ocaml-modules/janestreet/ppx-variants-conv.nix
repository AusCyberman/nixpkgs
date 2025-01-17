{lib, buildOcamlJane,
 ppx_core, ppx_tools, ppx_type_conv, sexplib, variantslib}:

buildOcamlJane {
  pname = "ppx_variants_conv";
  hash = "0kgal8b9yh7wrd75hllb9fyl6zbksfnr9k7pykpzdm3js98dirhn";
  propagatedBuildInputs = [ ppx_core ppx_tools ppx_type_conv sexplib variantslib ];

  meta = with lib; {
    description = "Generation of accessor and iteration functions for ocaml variant types";
    maintainers = [ maintainers.maurer ];
    license = licenses.asl20;
  };
}
