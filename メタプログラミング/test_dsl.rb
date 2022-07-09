lambda {
    setups = []
    profiles = {}

    Kernel.module_eval do
        define_method :profile do |entry, &block|
            profiles[entry] = block
        end

        define_method :setup do |&block|
            setups << block
        end

        define_method :each_profile do |&block|
            profiles.each_pair do |entry, profile|
                block.call entry, profile
            end
        end

        define_method :each_setup do |&block|
            setups.each do |setup|
                block.call setup
            end
        end
    end

    class CleanRoom
    end
}.call

Dir.glob('dsl.rb').each do |file|
    load file
    each_profile do |entry, profile|
        env = CleanRoom.new
        each_setup do |setup|
            env.instance_eval(&setup)
        end
        puts entry if env.instance_eval(&profile)
    end
end