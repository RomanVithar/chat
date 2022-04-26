package com.example.websocket.controler;


//
//@CrossOrigin(origins = "*", maxAge = 3600)
//@RestController
//public class TestController {
//
//    @Autowired
//    private AuthenticationManager authenticationManager;
//
//    @Autowired
//    private MyUserDetailsService userDetailsService;
//
//    @Autowired
//    private JwtUtil jwtUtil;
//
//    @GetMapping("/test")
//    @PreAuthorize("hasRole('ROLE_USER')")
//    public String test() {
//        System.out.println(
//                SecurityContextHolder.getContext().getAuthentication().getName()
//        );
//        return ("<h1>test complete!</h1>");
//    }
//
//    @RequestMapping(path="/authenticate", method=RequestMethod.POST)
//    public ResponseEntity<?> createAuthToken(
//            @RequestBody AuthenticationRequestDTO authenticationRequestDTO) throws Exception {
//        try {
//            authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(
//                    authenticationRequestDTO.getLogin(),
//                    authenticationRequestDTO.getPassword()
//            ));
//        } catch (BadCredentialsException e) {
//            throw new Exception("Incorrect username or password", e);
//        }
//        final MyUserDetails userDetails = (MyUserDetails) userDetailsService
//                .loadUserByUsername(authenticationRequestDTO.getLogin());
//        final String jwt = jwtUtil.generateJwtToken(userDetails);
//        return ResponseEntity.ok(new AuthenticationResponseDTO(jwt));
//    }
//}
