component extends="testbox.system.BaseSpec" {

    // TODO: remove this whole component once the first real test is implemented
    public function run() {
        describe( "dummy test", function() {
            it( "should always be fine", function() {
                var dummyText = "dummy";
                expect( dummyText ).toBe( "dummy" );
            });
        });
    }
}